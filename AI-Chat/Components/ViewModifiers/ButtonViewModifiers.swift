//
//  ButtonViewModifiers.swift
//  AI-Chat
//
//  Created by Soham Divekar on 15/12/2024.
//

import SwiftUI

struct HighlightButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                configuration.isPressed ? Color.accent.opacity(0.4) : Color.accent.opacity(0)
            }
            .animation(.smooth, value: configuration.isPressed)
    }
}

struct PressableButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .overlay {
                configuration.isPressed ? Color.accent.opacity(0.4) : Color.accent.opacity(0)
            }
            .animation(.smooth, value: configuration.isPressed)
    }
}

enum ButtonStyleOption {
    case plain, press, highlight
}

extension View {
    
    @ViewBuilder
    func anyButton(_ option: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
        switch option {
            case .plain:
                self.plainButton(action: action)
            case .press:
                self.pressableButton(action: action)
            case .highlight:
                self.highlightButton(action: action)
        }	
    }
    
    private func plainButton(action: @escaping () -> Void) -> some View {
        Button { action() } label: { self }
            .buttonStyle(.plain)
    }
    
    private func highlightButton(action: @escaping () -> Void) -> some View {
        Button { action() } label: { self }
            .buttonStyle(HighlightButtonStyle())
    }
    
    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button { action() } label: { self }
            .buttonStyle(PressableButtonStyle())
    }
}

#Preview {
    VStack(spacing: 24) {
        Button("Plain Button") {}
        
        Button("Button with tappable Background") {}
            .padding()
            .frame(maxWidth: .infinity)
            .tappableBackground()
        
        Button("Button with CTA Styling") {}
            .callToActionButton()
        
        Button {} label: {
            Text("Button with HighlightButtonStyle")
                .padding()
                .frame(maxWidth: .infinity)
                .tappableBackground()
        }
        .buttonStyle(HighlightButtonStyle())
        
        Text("View Modifier for HighlightButtonStyle")
            .padding()
            .frame(maxWidth: .infinity)
            .tappableBackground()
            .anyButton(.highlight) {}
        
        Button {} label: {
            Text("Button with PressableButtonStyle")
                .padding()
                .frame(maxWidth: .infinity)
                .callToActionButton()
        }
        .buttonStyle(PressableButtonStyle())
        
        Text("View Modifier for PressableButtonStyle")
            .padding()
            .frame(maxWidth: .infinity)
            .tappableBackground()
            .anyButton(.press) {}
        
        Text("Plain Button Wrapper")
            .callToActionButton()
            .anyButton {}
    }
    .padding()
}
