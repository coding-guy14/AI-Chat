//
//  ChatManager.swift
//  AI-Chat
//
//  Created by Soham Divekar on 19/12/2024.
//

import Foundation

protocol ChatService: Sendable {
    
    func createNewChat(chat: ChatModel) async throws
}

struct MockChatService: ChatService {
    
    func createNewChat(chat: ChatModel) async throws {
        
    }
}

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseChatService: ChatService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("chats")
    }
    
    func createNewChat(chat: ChatModel) async throws {
//        try collection.document(
    }
}
