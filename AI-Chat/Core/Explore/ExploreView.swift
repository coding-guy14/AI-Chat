//
//  ExploreView.swift
//  AI-Chat
//
//  Created by Soham Divekar on 14/12/2024.
//

import SwiftUI

struct ExploreView: View {
    
    @Environment(AvatarManager.self) private var avatarManager
    
    @State private var featuredAvatars: [AvatarModel] = []
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    @State private var popularAvatars: [AvatarModel] = []
    
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                
                if featuredAvatars.isEmpty && popularAvatars.isEmpty {
                    ProgressView()
                        .padding(40)
                        .frame(maxWidth: .infinity)
                        .removeListRowFormatting()
                }
                
                if !featuredAvatars.isEmpty {
                    featuredSection
                }
                
                if !popularAvatars.isEmpty {
                    categorySection
                    popularSection
                }
            }
            .navigationTitle("Explore")
            .navigationDestinationForCoreModule(path: $path)
            .task { await loadFeaturedAvatars() }
            .task { await loadPopularAvatars() }
            .refreshable {
                Task { await loadFeaturedAvatars() }
                Task { await loadPopularAvatars() }
            }
        }
    }
    
    private func loadFeaturedAvatars() async {
        guard featuredAvatars.isEmpty else { return }
        do {
            featuredAvatars = try await avatarManager.getFeaturedAvatars()
        } catch {
            print("Error loading featured avatars: \(error).")
        }
    }
    
    private func loadPopularAvatars() async {
        guard popularAvatars.isEmpty else { return }
        do {
            popularAvatars = try await avatarManager.getPopularAvatars()
        } catch {
            print("Error loading popular avatars: \(error).")
        }
    }
    
    private var featuredSection: some View {
        Section {
            ZStack {
                CarouselView(items: featuredAvatars) { avatar in
                    HeroCellView(
                        title: avatar.name,
                        subtitle: avatar.characterDescription,
                        imageName: avatar.profileImageName
                    )
                    .anyButton {
                        onAvatarPressed(avatar: avatar)
                    }
                }
            }
            .removeListRowFormatting()
        } header: {
            Text("Feautured")
        }
    }
    
    private var categorySection: some View {
        Section {
            ZStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            let imageName = popularAvatars.first(where: { $0.characterOption == category })?.profileImageName
                            if let imageName {
                                CategoryCellView(
                                    title: category.plural.capitalized,
                                    imageName: imageName
                                )
                                .anyButton {
                                    onCategoryPressed(category: category, imageName: imageName)
                                }
                            }
                        }
                    }
                }
                .frame(height: 140)
                .scrollIndicators(.hidden)
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
            }
            .removeListRowFormatting()
        } header: {
            Text("Categories")
        }
    }
    
    private var popularSection: some View {
        Section {
            ForEach(popularAvatars, id: \.self) { avatar in
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
        } header: {
            Text("Popular")
        }
    }
    
    private func onAvatarPressed(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
    
    private func onCategoryPressed(category: CharacterOption, imageName: String) {
        path.append(.category(option: category, imageName: imageName))
    }
}

#Preview {
    ExploreView()
        .environment(AvatarManager(service: MockAvatarService()))
}
