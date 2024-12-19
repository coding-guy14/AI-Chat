//
//  MockAvatarService.swift
//  AI-Chat
//
//  Created by Soham Divekar on 19/12/2024.
//

import SwiftUI

struct MockAvatarService: RemoteAvatarService {
    
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {}
    
    func getAvatar(id: String) async throws -> AvatarModel {
        AvatarModel.mocks.first { $0.avatarId == id } ?? .mock
    }
    
    func getFeaturedAvatars() async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(1))
        return AvatarModel.mocks.shuffled()
    }
    func getPopularAvatars() async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(2))
        return AvatarModel.mocks
    }
    
    func getAvatarsForCategory(category: CharacterOption) async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(2))
        return AvatarModel.mocks.filter { $0.characterOption == category }
    }
    
    func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(2))
        let result = AvatarModel.mocks.filter { $0.authorId == userId }
        if result.isEmpty {
            return AvatarModel.mocks.shuffled()
        } else {
            return result
        }
    }
    
    func incrementAvatarClickCount(avatarId: String) async throws {
        
    }
}
