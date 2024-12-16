//
//  ProfileModalView.swift
//  AI-Chat
//
//  Created by Soham Divekar on 16/12/2024.
//

import SwiftUI

struct ProfileModalView: View {
    
    var imageName: String? = Constants.randomImage
    var title: String? = "Alpha"
    var subtitle: String? = "Alien"
    var headline: String? = "An alien in the park."
    var onXmarkPressed: () -> Void = { }
    
    var body: some View {
        VStack(spacing: 0) {
            if let imageName {
                ImageLoaderView(urlString: imageName, forceTransitionAnimation: true)
                    .aspectRatio(1, contentMode: .fit)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                if let subtitle {
                    Text(subtitle)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                if let headline {
                    Text(headline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.thinMaterial)
        .cornerRadius(16)
        .overlay(alignment: .topTrailing) {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundStyle(.thickMaterial)
                .colorScheme(.dark)
                .padding(4)
                .tappableBackground()
                .anyButton {
                    onXmarkPressed()
                }
                .padding(8)
        }
    }
}

#Preview("Modal with Image") {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        ProfileModalView()
            .padding(40)
    }
}

#Preview("Modal without Image") {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        ProfileModalView(imageName: nil)
            .padding(40)
    }
}
