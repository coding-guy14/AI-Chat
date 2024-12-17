//
//  MockAuthService.swift
//  AI-Chat
//
//  Created by Soham Divekar on 17/12/2024.
//

import Foundation

struct MockAuthService: AuthService {
    
    let currentUser: UserAuthInfo?
    
    init(user: UserAuthInfo? = nil) {
        self.currentUser = user
    }
    
    func getAuthenticatedUser() -> UserAuthInfo? {
        currentUser
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: true)
        return (user, true)
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: false)
        return (user, false)
    }
    
    func signOut() throws {}
    
    func deleteAccount() async throws {}
}
