//
//  ChatMessageModel.swift
//  AI-Chat
//
//  Created by Soham Divekar on 15/12/2024.
//

import Foundation

struct ChatMessageModel: Identifiable {
    
    let id: String
    let chatId: String
    let authorId: String?
    let content: AIChatModel?
    let seenByIds: [String]?
    let dateCreated: Date?
    
    init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: AIChatModel? = nil,
        seenByIds: [String]? = nil,
        dateCreated: Date? = nil
    ) {
        self.id = id
        self.chatId = chatId
        self.authorId = authorId
        self.content = content
        self.seenByIds = seenByIds
        self.dateCreated = dateCreated
    }
    
    func hasBeenSeenByCurrentUser(userId: String) -> Bool {
        guard let seenByIds else { return false }
        return seenByIds.contains(userId)
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            ChatMessageModel(id: UUID().uuidString, chatId: "chat_1", authorId: "user_1", content: AIChatModel(role: .user, content: "Hello, how are you?"), seenByIds: ["user_2", "user_3"], dateCreated: .now),
            ChatMessageModel(id: UUID().uuidString, chatId: "chat_2", authorId: "user_2", content: AIChatModel(role: .assistant, content: "I'm doing well, thanks for asking!"), seenByIds: ["user_1"], dateCreated: .now.addingTimeInterval(minutes: -5)),
            ChatMessageModel(id: UUID().uuidString, chatId: "chat_3", authorId: "user_3", content: AIChatModel(role: .user, content: "Anyone up for a game tonight?"), seenByIds: ["user_1", "user_2", "user_4"], dateCreated: .now.addingTimeInterval(hours: -1)),
            ChatMessageModel(id: UUID().uuidString, chatId: "chat_1", authorId: "user_1", content: AIChatModel(role: .assistant, content: "Sure, count me in!"), seenByIds: nil, dateCreated: .now.addingTimeInterval(minutes: -15, hours: -2))
        ]
    }
}
