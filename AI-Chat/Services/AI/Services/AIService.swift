//
//  AIService.swift
//  AI-Chat
//
//  Created by Soham Divekar on 18/12/2024.
//

import SwiftUI

protocol AIService: Sendable {
    func generateImage(input: String) async throws -> UIImage
    func generateText(chats: [AIChatModel]) async throws -> AIChatModel
}
