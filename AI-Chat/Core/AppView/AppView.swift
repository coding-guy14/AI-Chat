//
//  AppView.swift
//  AI-Chat
//
//  Created by Soham Divekar on 14/12/2024.
//

import SwiftUI

struct AppView: View {
    
    @Environment(\.authService) private var authService
    @State var appState: AppState = AppState()
    
    var body: some View {
        
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabbarView: {
                TabBarView()
            },
            onBoardingView: {
                WelcomeView()
            }
        )
        .environment(appState)
        .task {
            await checkUserStatus()
        }
        .onChange(of: appState.showTabBar) { _, showTabBar in
            if !showTabBar {
                Task {
                    await checkUserStatus()
                }
            }
        }
    }
    
    private func checkUserStatus() async {
        if let user = authService.getAuthenticatedUser() {
            print("User already authenticated: \(user.uid)")
        } else {
            do {
                let result = try await authService.signInAnonymously()
                // log into app
                print("Sign in anonymous success: \(result.user.uid)")
            } catch {
                print(error)
            }
        }
    }
}

#Preview("AppView - Tabbar") {
    AppView(appState: AppState(showTabBar: true))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
}
