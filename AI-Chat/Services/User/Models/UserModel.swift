//
//  UserModel.swift
//  AI-Chat
//
//  Created by Soham Divekar on 15/12/2024.
//

import SwiftUI

struct UserModel {
    
    let userId: String
    let dateCreated: Date?
    let didCompletedOnboarding: Bool?
    let profileColorHex: String?
    
    init(
        userId: String,
        dateCreated: Date? = nil,
        didCompletedOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.dateCreated = dateCreated
        self.didCompletedOnboarding = didCompletedOnboarding
        self.profileColorHex = profileColorHex
    }
    
    var profileColorCalculated: Color {
        guard let profileColorHex else { return .accent }
        return Color(hex: profileColorHex)
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            UserModel(userId: UUID().uuidString, dateCreated: .now, didCompletedOnboarding: true, profileColorHex: "#33A1FF"),
            UserModel(userId: UUID().uuidString, dateCreated: .now.addingTimeInterval(days: -1), didCompletedOnboarding: false, profileColorHex: "#FF5733"),
            UserModel(userId: UUID().uuidString, dateCreated: .now.addingTimeInterval(hours: -2, days: -3), didCompletedOnboarding: true, profileColorHex: "#7DFF33"),
            UserModel(userId: UUID().uuidString, dateCreated: .now.addingTimeInterval(hours: -4, days: -5), didCompletedOnboarding: nil, profileColorHex: "#FF33A1")
        ]
    }
}
