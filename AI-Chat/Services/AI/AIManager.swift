//
//  AIManager.swift
//  AI-Chat
//
//  Created by Soham Divekar on 18/12/2024.
//

import SwiftUI

@MainActor
@Observable
class AIManager {
     
    private let service: AIService
    
    init(service: AIService) {
        self.service = service
    }
    
    func generateImage(input: String) async throws -> UIImage {
        try await service.generateImage(input: input)
    }
    
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel {
        return try await service.generateText(chats: chats)
    }
}
