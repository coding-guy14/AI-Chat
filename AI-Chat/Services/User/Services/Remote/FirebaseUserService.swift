//
//  FirebaseUserService.swift
//  AI-Chat
//
//  Created by Soham Divekar on 18/12/2024.
//

import Foundation
import FirebaseFirestore
import SwiftfulFirestore

typealias ListenerRegistration = FirebaseFirestore.ListenerRegistration

struct FirebaseUserService: RemoteUserService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(user: UserModel) throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }
    
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.didCompletedOnboarding.rawValue: true,
            UserModel.CodingKeys.profileColorHex.rawValue: profileColorHex
        ])
    }
    
    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId, onListenerConfigured: onListenerConfigured)
    }
    
    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
}
