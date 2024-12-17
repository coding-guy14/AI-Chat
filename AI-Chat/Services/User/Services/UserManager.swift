//
//  UserManager.swift
//  AI-Chat
//
//  Created by Soham Divekar on 17/12/2024.
//

import SwiftUI

protocol UserService: Sendable {
    
    func saveUser(user: UserModel) throws
}

import FirebaseFirestore

struct FirebaseUserService: UserService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(user: UserModel) throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }
}

@MainActor
@Observable
class UserManager {
    
    private let service: UserService
    private(set) var currerntUser: UserModel?
    
    init(service: UserService) {
        self.service = service
        self.currerntUser = nil
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        try service.saveUser(user: user)
    }
}
