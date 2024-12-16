//
//  AnyAlert.swift
//  AI-Chat
//
//  Created by Soham Divekar on 16/12/2024.
//

import SwiftUI

enum AlertType {
    case alert, confirmationDialog
}

struct AnyAlert: Sendable {
    var title: String
    var subtitle: String?
    var buttons: @Sendable () -> AnyView
    
    init(
        title: String,
        subtitle: String? = nil,
        buttons: (@Sendable () -> AnyView)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttons = buttons ?? { AnyView(Button("OK") {}) }
    }
}

extension View {
    
    @ViewBuilder
    func showCustomAlert(_ type: AlertType = .alert, alert: Binding<AnyAlert?>) -> some View {
        switch type {
            case .alert:
                self
                    .alert(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert)) {
                        alert.wrappedValue?.buttons()
                    } message: { if let message = alert.wrappedValue?.subtitle { Text(message) }}
            case .confirmationDialog:
                self
                    .confirmationDialog(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert)) {
                        alert.wrappedValue?.buttons()
                    } message: { if let message = alert.wrappedValue?.subtitle { Text(message) }}
        }
    }
}
