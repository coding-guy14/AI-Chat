//
//  UserServices.swift
//  AI-Chat
//
//  Created by Soham Divekar on 18/12/2024.
//

import Foundation

protocol UserServices {
    var local: LocalUserPersistence { get }
    var remote: RemoteUserService { get }
    
}

struct MockUserServices: UserServices {
    let local: LocalUserPersistence
    let remote: RemoteUserService
    
    init(user: UserModel? = nil) {
        self.local = MockUserPersistence(user: user)
        self.remote = MockUserService(user: user)
    }
}

struct ProductionUserServices: UserServices {
    let local: LocalUserPersistence = FileManagerUserPersistence()
    let remote: RemoteUserService = FirebaseUserService()
}
