//
//  FirebaseAuthService.swift
//  AI-Chat
//
//  Created by Soham Divekar on 17/12/2024.
//

import SwiftUI
import FirebaseAuth
import SignInAppleAsync

struct FirebaseAuthService: AuthService {
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        if let user = Auth.auth().currentUser {
            return UserAuthInfo(user: user)
        }
        return nil
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let result = try await Auth.auth().signInAnonymously()
        return result.asAuthInfo
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let helper = await SignInWithAppleHelper()
        let response = try await helper.signIn()
        
        let credential = OAuthProvider.credential(
            providerID: .apple,
            idToken: response.token,
            rawNonce: response.nonce
        )
        
        if let user = Auth.auth().currentUser, user.isAnonymous {
            do {
                let result = try await user.link(with: credential)
                return result.asAuthInfo
            } catch let error as NSError {
                let authError = AuthErrorCode(rawValue: error.code)
                switch authError {
                    case .providerAlreadyLinked, .credentialAlreadyInUse:
                        if let secondaryCredential = error.userInfo["FIRAuthErrorUserInfoUpdatedCredentialKey"] as? AuthCredential {
                            let result = try await Auth.auth().signIn(with: secondaryCredential)
                            return result.asAuthInfo
                        }
                    default: break
                }
            }
        }
        
        // Otherwise sign into new account
        let result = try await Auth.auth().signIn(with: credential)
        return result.asAuthInfo
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else { throw AuthError.userNotFound }
        
        try await user.delete()
    }
}

enum AuthError: LocalizedError {
    case userNotFound
    
    var errorDescription: String? {
        switch self {
            case .userNotFound: return "Current authenticated user not found."
        }
    }
}

extension AuthDataResult {
    
    var asAuthInfo: (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo(user: user)
        let isNewUser = additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)
    }
}
