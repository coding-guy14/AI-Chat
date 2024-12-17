//
//  MockUserService.swift
//  AI-Chat
//
//  Created by Soham Divekar on 18/12/2024.
//

import Foundation

struct MockUserService: RemoteUserService {
    
    let currentUser: UserModel?
    
    init(user: UserModel? = nil) {
        self.currentUser = user
    }
    
    func saveUser(user: UserModel) throws {}
    
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {}
    
    func streamUser(userId: String, onListenerConfigured: @escaping (any ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, any Error> {
        AsyncThrowingStream { continuation in
            if let currentUser { continuation.yield(currentUser) }
        }
    }
    
    func deleteUser(userId: String) async throws {}
}
