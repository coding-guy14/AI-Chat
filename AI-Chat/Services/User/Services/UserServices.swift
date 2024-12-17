//
//  UserServices.swift
//  AI-Chat
//
//  Created by Soham Divekar on 18/12/2024.
//

import Foundation

protocol UserServices {
    var local: LocalUserPersistance { get }
    var remote: RemoteUserService { get }
    
}

struct MockUserServices: UserServices {
    let local: LocalUserPersistance
    let remote: RemoteUserService
    
    init(user: UserModel? = nil) {
        self.local = MockUserPersistance(user: user)
        self.remote = MockUserService(user: user)
    }
}

struct ProductionUserServices: UserServices {
    let local: LocalUserPersistance = FileManagerUserPersistance()
    let remote: RemoteUserService = FirebaseUserService()
}
