//
//  ChatModel.swift
//  AI-Chat
//
//  Created by Soham Divekar on 15/12/2024.
//

import Foundation

struct ChatModel: Identifiable {
    
    let id: String
    let userId: String
    let avatarId: String
    let dateCreated: Date
    let dateModified: Date
    
    static var mock: ChatModel {
        mocks[0]
    }
    
    static var mocks: [ChatModel] {
        [
            ChatModel(id: UUID().uuidString, userId: "user_1", avatarId: "avatar_1", dateCreated: .now, dateModified: .now),
            ChatModel(id: UUID().uuidString, userId: "user_2", avatarId: "avatar_2", dateCreated: .now.addingTimeInterval(hours: -1), dateModified: .now.addingTimeInterval(minutes: -30)),
            ChatModel(id: UUID().uuidString, userId: "user_3", avatarId: "avatar_3", dateCreated: .now.addingTimeInterval(hours: -2), dateModified: .now.addingTimeInterval(hours: -1)),
            ChatModel(id: UUID().uuidString, userId: "user_4", avatarId: "avatar_4", dateCreated: .now.addingTimeInterval(days: -1), dateModified: .now.addingTimeInterval(hours: -10))
        ]
    }
}
