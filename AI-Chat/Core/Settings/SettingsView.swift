//
//  SettingsView.swift
//  AI-Chat
//
//  Created by Soham Divekar on 15/12/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.authService) private var authService
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    
    @State private var isPremium: Bool = false
    @State private var isAnonymousUser: Bool = false
    @State private var showCreateAccountView: Bool = false
    @State private var showAlert: AnyAlert?
    
    var body: some View {
        NavigationStack {
            List {
                accountSection
                purchaseSection
                applicationSection
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showCreateAccountView, onDismiss: {
                setAnonymousAccountStatus()
            }, content: {
                CreateAccountView()
                    .presentationDetents([.medium])
            })
        }
        .onAppear {
            setAnonymousAccountStatus()
        }
        .showCustomAlert(alert: $showAlert)
    }
    
    private var accountSection: some View {
        Section {
            if isAnonymousUser {
                Text("Save & back-up account")
                    .rowFormatting()
                    .anyButton(.highlight) {
                        onCreateAccountPressed()
                    }
                    .removeListRowFormatting()
            } else {
                Text("Sign Out")
                    .rowFormatting()
                    .anyButton(.highlight) {
                        onSignOutPressed()
                    }
                    .removeListRowFormatting()
            }
            
            Text("Delete Account")
                .foregroundStyle(.red)
                .rowFormatting()
                .anyButton(.highlight) {
                    onDeleteAccountPressed()
                }
                .removeListRowFormatting()
        } header: {
            Text("Account")
        }
    }
    
    private var purchaseSection: some View {
        Section {
            HStack(spacing: 8) {
                Text("Account Status: \(isPremium ? "PREMIUM" : "FREE")")
                Spacer(minLength: 0)
                if isPremium {
                    Text("MANAGE")
                        .badgeButton()
                }
            }
            .rowFormatting()
            .anyButton(.highlight) {
                onSignOutPressed()
            }
            .disabled(!isPremium)
            .removeListRowFormatting()
        } header: {
            Text("Purchases")
        }
    }
    
    private var applicationSection: some View {
        Section {
            HStack(spacing: 8) {
                Text("Version")
                Spacer(minLength: 0)
                Text(Utilities.appVersion ?? "")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            .removeListRowFormatting()
            
            HStack(spacing: 8) {
                Text("Build Number")
                Spacer(minLength: 0)
                Text(Utilities.buildNumber ?? "")
                    .foregroundStyle(.secondary)
            }
            .rowFormatting()
            .removeListRowFormatting()
            
            Text("Contact Us")
                .foregroundStyle(.blue)
            .rowFormatting()
            .anyButton(.highlight) {
                
            }
            .removeListRowFormatting()
        } header: {
            Text("Application")
        } footer: {
            Text("Created by Soham Divekar.\nCreated as part of the Swift Advanced Architecture course by SwiftfulThinking.")
                .baselineOffset(6)
        }
    }
    
    func onSignOutPressed() {
        Task {
            do {
                try authService.signOut()
                dismissScreen()
            } catch {
                showAlert = AnyAlert(error: error)
            }
        }
    }
    
    func onDeleteAccountPressed() {
        showAlert = AnyAlert(title: "Delete Account?", subtitle: "This action is permanent and cannot be undone. Your data will be deleted forever", buttons: {
            AnyView(
                Button("Delete", role: .destructive, action: {
                    onDeleteAccountConfirmed()
                })
            )
        })
    }
    
    private func onDeleteAccountConfirmed() {
        Task {
            do {
                try await authService.deleteAccount()
                dismissScreen()
            } catch {
                showAlert = AnyAlert(error: error)
            }
        }
    }
    
    private func dismissScreen() {
        dismiss()
        appState.updateViewState(showTabBarView: false)
    }
        
    func onCreateAccountPressed() {
        showCreateAccountView = true
    }
    
    func setAnonymousAccountStatus() {
        isAnonymousUser = authService.getAuthenticatedUser()?.isAnonymous == true
    }
}

fileprivate extension View {
    
    func rowFormatting() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(uiColor: .systemBackground))
    }
}

#Preview("No Auth") {
    SettingsView()
        .environment(\.authService, MockAuthService(user: nil))
        .environment(AppState())
}

#Preview("Anonymous") {
    SettingsView()
        .environment(\.authService, MockAuthService(user: .mock(isAnonymous: true)))
        .environment(AppState())
}

#Preview("Not Anonymous") {
    SettingsView()
        .environment(\.authService, MockAuthService(user: .mock(isAnonymous: false)))
        .environment(AppState())
}
