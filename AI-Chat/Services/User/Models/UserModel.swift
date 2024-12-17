//
//  UserModel.swift
//  AI-Chat
//
//  Created by Soham Divekar on 15/12/2024.
//

import SwiftUI

struct UserModel: Codable {
    
    let userId: String
    let email: String?
    let isAnonymous: Bool?
    let creationDate: Date?
    let creationVersion: String?
    let lastSignInDate: Date?
    let didCompletedOnboarding: Bool?
    let profileColorHex: String?
    
    init(
        userId: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        creationDate: Date? = nil,
        creationVersion: String? = nil,
        lastSignInDate: Date? = nil,
        didCompletedOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.creationVersion = creationVersion
        self.lastSignInDate = lastSignInDate
        self.didCompletedOnboarding = didCompletedOnboarding
        self.profileColorHex = profileColorHex
    }
    
    init(auth: UserAuthInfo, creationVersion: String?) {
        self.init(userId: auth.uid, email: auth.email, isAnonymous: auth.isAnonymous, creationDate: auth.creationDate, creationVersion: creationVersion, lastSignInDate: auth.lastSignInDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case isAnonymous = "is_anonymous"
        case creationDate = "creation_date"
        case creationVersion = "creation_version"
        case lastSignInDate = "last_sign_in_date"
        case didCompletedOnboarding = "did_completed_onboarding"
        case profileColorHex = "profile_color_hex"
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
            UserModel(userId: "user_1", creationDate: .now, didCompletedOnboarding: true, profileColorHex: "#33A1FF"),
            UserModel(userId: "user_2", creationDate: .now.addingTimeInterval(days: -1), didCompletedOnboarding: false, profileColorHex: "#FF5733"),
            UserModel(userId: "user_3", creationDate: .now.addingTimeInterval(hours: -2, days: -3), didCompletedOnboarding: true, profileColorHex: "#7DFF33"),
            UserModel(userId: "user_4", creationDate: .now.addingTimeInterval(hours: -4, days: -5), didCompletedOnboarding: nil, profileColorHex: "#FF33A1")
        ]
    }
}
