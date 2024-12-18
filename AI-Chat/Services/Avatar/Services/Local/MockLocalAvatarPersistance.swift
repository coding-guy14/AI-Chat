//
//  MockLocalAvatarPersistance.swift
//  AI-Chat
//
//  Created by Soham Divekar on 19/12/2024.
//

import Foundation

@MainActor
struct MockLocalAvatarPersistance: LocalAvatarPersistance {
    
    func addRecentAvatar(avatar: AvatarModel) throws {
        
    }
    
    func getRecentAvatars() throws -> [AvatarModel] {
        AvatarModel.mocks.shuffled()
    }
}
