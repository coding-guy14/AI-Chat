//
//  ChatsView.swift
//  AI-Chat
//
//  Created by Soham Divekar on 14/12/2024.
//

import SwiftUI

struct ChatsView: View {
    
    @State private var chats: [ChatModel] = ChatModel.mocks
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(chats) { chat in 
                    Text(chat.id)
                }
            }
                .navigationTitle("Charts")
        }
    }
}

#Preview {
    ChatsView()
}
