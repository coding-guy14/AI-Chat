//
//  NavigationPathOption.swift
//  AI-Chat
//
//  Created by Soham Divekar on 17/12/2024.
//

import SwiftUI

enum NavigationPathOption: Hashable {
    case chat(avatarId: String)
    case category(option: CharacterOption, imageName: String)
}

extension View {
    
    func navigationDestinationForCoreModule(path: Binding<[NavigationPathOption]>) -> some View {
        self
            .navigationDestination(for: NavigationPathOption.self) { newValue in
                switch newValue {
                    case .chat(avatarId: let avatarId):
                        ChatView(avatarId: avatarId)
                    case .category(option: let category, imageName: let imageName):
                        CategoryList(path: path, category: category, imageName: imageName)
                }
            }
    }
}
