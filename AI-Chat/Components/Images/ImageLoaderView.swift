//
//  ImageLoaderView.swift
//  AI-Chat
//
//  Created by Soham Divekar on 15/12/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    var urlString: String = Constants.randomImage
    var resizingMode: ContentMode = .fill
    var forceTransitionAnimation: Bool = false
    
    var body: some View {
        Rectangle()
            .opacity(0.0001)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(false)
            }
            .clipped()
            .ifStatisfiesCondition(forceTransitionAnimation) { content in
                content
                    .drawingGroup()
            }
    }
}

#Preview {
    ImageLoaderView()
        .frame(width: 300, height: 200)
        .anyButton(.highlight) {
            
        }
}
