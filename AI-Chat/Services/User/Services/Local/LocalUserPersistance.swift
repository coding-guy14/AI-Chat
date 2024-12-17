//
//  LocalUserPersistance.swift
//  AI-Chat
//
//  Created by Soham Divekar on 18/12/2024.
//

import Foundation

protocol LocalUserPersistance {
    
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel?) throws
}
