//
//  LocalAvatarPersistance.swift
//  AI-Chat
//
//  Created by Soham Divekar on 19/12/2024.
//

import Foundation

@MainActor
protocol LocalAvatarPersistance {
    
    func addRecentAvatar(avatar: AvatarModel) throws
    func getRecentAvatars() throws -> [AvatarModel]
}
