//
//  CategoryList.swift
//  AI-Chat
//
//  Created by Soham Divekar on 16/12/2024.
//

import SwiftUI

struct CategoryList: View {
    
    @Environment(AvatarManager.self) private var avatarManager
    
    @Binding var path: [NavigationPathOption]
    
    var category: CharacterOption = .alien
    var imageName: String = Constants.randomImage
    
    @State private var avatars: [AvatarModel] = []
    @State private var showAlert: AnyAlert?
    @State private var isLoading: Bool = true
    
    var body: some View {
        List {
            CategoryCellView(
                title: category.plural.capitalized,
                imageName: imageName,
                font: .largeTitle,
                cornerRadius: 0
            )
            .removeListRowFormatting()
            
            if avatars.isEmpty && isLoading {
                ProgressView()
                    .padding(40)
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
                    .removeListRowFormatting()
                
            } else {
                ForEach(avatars, id: \.self) { avatar in
                    CustomListCellView(
                        imageName: avatar.profileImageName,
                        title: avatar.name,
                        subtitle: avatar.characterDescription
                    )
                    .anyButton(.highlight) {
                        onAvatarPressed(avatar: avatar)
                    }
                    .removeListRowFormatting()
                }
            }
        }
        .showCustomAlert(alert: $showAlert)
        .listStyle(.plain)
        .ignoresSafeArea()
        .task {
            await loadAvatars()
        }
    }
    
    private func loadAvatars() async {
        do {
            avatars = try await avatarManager.getAvatarsForCategory(category: category)
        } catch {
            showAlert = AnyAlert(error: error)
        }
        
        isLoading = false
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
}

#Preview {
    NavigationStack {
        CategoryList(path: .constant([]))
    }
    .environment(AvatarManager(service: MockAvatarService()))
}
