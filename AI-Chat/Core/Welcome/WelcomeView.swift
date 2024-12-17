//
//  WelcomeView.swift
//  AI-Chat
//
//  Created by Soham Divekar on 14/12/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(AppState.self) private var root
    
    @State var imageName: String = Constants.randomImage
    @State private var showSignInView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                
                ImageLoaderView(urlString: imageName)
                    .ignoresSafeArea()
                
                titleSection
                    .padding(.top, 24)
                
                ctaButtons
                    .padding(16)
                
               policyLinks
            }
        }
        .sheet(isPresented: $showSignInView) {
            CreateAccountView(
                title: "Sign In",
                subtitle: "Connect to an existing account.",
                onDidSignIn: { isNewUser in
                    handleDidSignIn(isNewUser: isNewUser)
                }
            )
            .presentationDetents([.medium])
        }
    }
    
    private var titleSection: some View {
        VStack(spacing: 8) {
            Text("AI Chat")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text("YouTube @ SwiftfulThinking")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private var ctaButtons: some View {
        VStack(spacing: 8) {
            NavigationLink {
                OnboardingIntroView()
            } label: {
                Text("Get Started")
                    .callToActionButton()
            }
            
            Text("Already have an account? Sign In.")
                .underline()
                .font(.body)
                .padding(8)
                .tappableBackground()
                .onTapGesture {
                    onSignInPressed()
                }
        }
    }
    
    private var policyLinks: some View {
        HStack(spacing: 8) {
            Link(destination: URL(string: Constants.termsOfServiceUrl)!) {
                Text("Terms of Service")
            }
            
            Circle()
                .fill(.accent)
                .frame(width: 4, height: 4)
            
            Link(destination: URL(string: Constants.privacyPolicyUrl)!) {
                Text("Privacy Policy")
            }
        }
    }
    
    private func handleDidSignIn(isNewUser: Bool) {
        if !isNewUser {
            root.updateViewState(showTabBarView: true)
        }
    }
    
    private func onSignInPressed() {
        showSignInView = true
    }
}

#Preview {
    WelcomeView()
}
