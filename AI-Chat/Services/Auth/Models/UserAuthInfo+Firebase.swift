//
//  UserAuthInfo+Firebase.swift
//  AI-Chat
//
//  Created by Soham Divekar on 17/12/2024.
//

import Foundation
import FirebaseAuth

extension UserAuthInfo {
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
