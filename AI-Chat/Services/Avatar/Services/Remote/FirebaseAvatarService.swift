//
//  FirebaseAvatarService.swift
//  AI-Chat
//
//  Created by Soham Divekar on 19/12/2024.
//

import SwiftUI
import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseAvatarService: RemoteAvatarService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("avatars")
    }
    
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {
        let path = "avatars/\(avatar.avatarId)"
        let url = try await FirebaseImageUploadService().uploadImage(path: path, image: image)
        
        var avatar = avatar
        avatar.updateProfileImage(imageName: url.absoluteString)
        
        try collection.document(avatar.avatarId).setData(from: avatar, merge: true)
    }
    
    func getAvatar(id: String) async throws -> AvatarModel {
        try await collection.getDocument(id: id)
    }
    
    func getFeaturedAvatars() async throws -> [AvatarModel] {
        try await collection
            .limit(to: 10)
            .getAllDocuments()
            .shuffled()
            .first(upto: 5) ?? []
    }
    
    func getPopularAvatars() async throws -> [AvatarModel] {
        try await collection
            .limit(to: 100)
            .getAllDocuments()
            .first(upto: 5) ?? []
    }
    
    func getAvatarsForCategory(category: CharacterOption) async throws -> [AvatarModel] {
        try await collection
            .whereField(AvatarModel.CodingKeys.characterOption.rawValue, isEqualTo: category.rawValue)
            .limit(to: 50)
            .getAllDocuments()
    }
    
    func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel] {
        try await collection
            .whereField(AvatarModel.CodingKeys.authorId.rawValue, isEqualTo: userId)
            .getAllDocuments()
    }
}
