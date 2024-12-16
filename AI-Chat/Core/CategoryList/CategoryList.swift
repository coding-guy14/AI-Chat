//
//  CategoryList.swift
//  AI-Chat
//
//  Created by Soham Divekar on 16/12/2024.
//

import SwiftUI

struct CategoryList: View {
    
    var category: CharacterOption = .alien
    var imageName: String = Constants.randomImage
    
    @State private var avatars: [AvatarModel] = AvatarModel.mocks
    
    var body: some View {
        List {
            CategoryCellView(
                title: category.plural.capitalized,
                imageName: imageName,
                font: .largeTitle,
                cornerRadius: 0
            )
            .removeListRowFormatting()
            
            ForEach(avatars, id: \.self) { avatar in
                CustomListCellView(
                    imageName: avatar.profileImageName,
                    title: avatar.name,
                    subtitle: avatar.characterDescription
                )
                .removeListRowFormatting()
            }
        }
        .listStyle(.plain)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        CategoryList()
    }
}
