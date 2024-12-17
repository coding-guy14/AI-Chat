//
//  FileManagerUserPersistance.swift
//  AI-Chat
//
//  Created by Soham Divekar on 18/12/2024.
//

import Foundation

struct FileManagerUserPersistance: LocalUserPersistance {
    
    private let userDocumentKey: String = "current_user"
    
    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userDocumentKey)
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        try FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}
