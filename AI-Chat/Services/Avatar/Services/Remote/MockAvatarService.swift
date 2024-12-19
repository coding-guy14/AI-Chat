//
//  MockAvatarService.swift
//  AI-Chat
//
//  Created by Soham Divekar on 19/12/2024.
//

import SwiftUI

struct MockAvatarService: RemoteAvatarService {
    
    let avatars: [AvatarModel]
    let delay: Double
    let showError: Bool
    
    init(avatars: [AvatarModel] = AvatarModel.mocks, delay: Double = 2.0, showError: Bool = false) {
        self.avatars = avatars
        self.delay = delay
        self.showError = showError
    }
    
    private func tryShowError() throws {
        if showError {
            throw URLError(.unknown)
        }
    }
    
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {
        try tryShowError()
    }
    
    func getAvatar(id: String) async throws -> AvatarModel {
        try tryShowError()
        guard let avatar = avatars.first(where: { $0.id == id }) else { throw URLError(.noPermissionsToReadFile) }
        return avatar
    }
    
    func getFeaturedAvatars() async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return avatars.shuffled()
    }
    func getPopularAvatars() async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return avatars
    }
    
    func getAvatarsForCategory(category: CharacterOption) async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        return avatars.filter { $0.characterOption == category }
    }
    
    func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] {
        try await Task.sleep(for: .seconds(delay))
        try tryShowError()
        let result = avatars.filter { $0.authorId == userId }
        if result.isEmpty {
            return avatars.shuffled()
        } else {
            return result
        }
    }
    
    func removeAuthorIdFromAvatar(avatarId: String) async throws {
        
    }
    
    func removeAuthorIdFromAllUserAvatars(userId: String) async throws {
        
    }
    
    func incrementAvatarClickCount(avatarId: String) async throws {
        
    }
}
