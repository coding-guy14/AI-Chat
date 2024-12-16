//
//  ModalSupportView.swift
//  AI-Chat
//
//  Created by Soham Divekar on 16/12/2024.
//

import SwiftUI

struct ModalSupportView<Content: View>: View {
    
    @Binding var showModal: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            if showModal {
                Color.black.opacity(0.0001).ignoresSafeArea()
                    .background(.ultraThinMaterial)
                    .colorScheme(.dark)
                    .transition(AnyTransition.opacity.animation(.smooth))
                    .onTapGesture {
                        showModal = false
                    }
                    .zIndex(1)
                
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .zIndex(2)
            }
        }
        .zIndex(9999)
        .animation(.bouncy, value: showModal)
    }
}

extension View {
    
    func showModal(showModal: Binding<Bool>, @ViewBuilder content: () -> some View) -> some View {
        self
            .overlay {
                ModalSupportView(showModal: showModal) {
                    content()
                }
            }
    }
}

private struct PreviewView: View {
    
    @State private var showModal: Bool = false
    
    var body: some View {
        Button("Click Me") {
            showModal = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .showModal(showModal: $showModal) {
            RoundedRectangle(cornerRadius: 30)
                .fill(.black)
                .padding(40)
                .padding(.vertical, 100)
                .transition(.move(edge: .bottom))
        }
    }
}

#Preview {
    PreviewView()
}
