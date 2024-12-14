//
//  WelcomeView.swift
//  AI-Chat
//
//  Created by Soham Divekar on 14/12/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Weclome")
                    .frame(maxHeight: .infinity)
                
                NavigationLink {
                    OnbardingCompletedView()
                } label: {
                    Text("Get Started")
                        .callToActionButton()
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    WelcomeView()
}
