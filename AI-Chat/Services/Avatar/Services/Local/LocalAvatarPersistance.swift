//
//  LocalAvatarPersistence.swift
//  AI-Chat
//
//  Created by Soham Divekar on 19/12/2024.
//

import Foundation

@MainActor
protocol LocalAvatarPersistence {
    
    func addRecentAvatar(avatar: AvatarModel) throws
    func getRecentAvatars() throws -> [AvatarModel]
}
