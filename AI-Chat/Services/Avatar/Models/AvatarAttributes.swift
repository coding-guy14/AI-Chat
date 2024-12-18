//
//  AvatarAttributes.swift
//  AI-Chat
//
//  Created by Soham Divekar on 16/12/2024.
//

enum CharacterOption: String, CaseIterable, Codable, Hashable {
    case man, woman, alien, dog, cat
    
    static var `default`: Self {
        .man
    }
    
    var plural: String {
        switch self {
            case .man: return "men"
            case .woman: return "women"
            case .alien: return "aliens"
            case .dog: return "dogs"
            case .cat: return "cats"
        }
    }
    
    var statsWithAVowel: Bool {
        switch self {
            case .alien: return true
            default: return false
        }
    }
}

enum CharacterAction: String, CaseIterable, Codable, Hashable {
    case smiling, sitting, eating, drinking, walking, shopping, studying, working, relaxing, fighting, crying
    
    static var `default`: Self {
        .smiling
    }
}

enum CharacterLocation: String, CaseIterable, Codable, Hashable {
    case park, mall, museum, city, desert, forest, space
    
    static var `default`: Self {
        .park
    }
}

struct AvatarDescriptionBuilder {
    let option: CharacterOption
    let action: CharacterAction
    let location: CharacterLocation
    
    init(option: CharacterOption, action: CharacterAction, location: CharacterLocation) {
        self.option = option
        self.action = action
        self.location = location
    }
    
    init(avatar: AvatarModel) {
        self.option = avatar.characterOption ?? .default
        self.action = avatar.characterAction ?? .default
        self.location = avatar.characterLocation ?? .default
    }
    
    var characterDescription: String {
        let prefix = option.statsWithAVowel ? "An" : "A"
        return "\(prefix) \(option.rawValue) that is \(action.rawValue) in the \(location.rawValue)"
    }
}
