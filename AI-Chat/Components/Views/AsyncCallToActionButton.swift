//
//  AsyncCallToActionButton.swift
//  AI-Chat
//
//  Created by Soham Divekar on 16/12/2024.
//

import SwiftUI

struct AsyncCallToActionButton: View {
    
    var isLoading: Bool
    var title: String = "Save"
    var action: () -> Void
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(title)
            }
        }
        .callToActionButton()
        .anyButton(.press) {
            action()
        }
        .disabled(isLoading)
    }
}

private struct PreviewView: View {
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        AsyncCallToActionButton(
            isLoading: isLoading,
            title: "Finish") {
                isLoading = true
                
                Task {
                    try? await Task.sleep(for: .seconds(3))
                    isLoading = false
                }
            }
    }
}

#Preview {
    PreviewView()
        .padding()
}
