//
//  MockUserPersistance.swift
//  AI-Chat
//
//  Created by Soham Divekar on 18/12/2024.
//

import Foundation

struct MockUserPersistance: LocalUserPersistance {
    
    let currentUser: UserModel?
    
    init(user: UserModel? = nil) {
        self.currentUser = user
    }
    
    func getCurrentUser() -> UserModel? {
        currentUser
    }
    
    func saveCurrentUser(user: UserModel?) throws {}
}
