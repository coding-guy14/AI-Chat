//
//  RemoteUserService.swift
//  AI-Chat
//
//  Created by Soham Divekar on 18/12/2024.
//

import Foundation

protocol RemoteUserService: Sendable {
    
    func saveUser(user: UserModel) throws
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws
    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
}
