//
//  SettingsViewModel.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 06.03.2023.
//

import Foundation

enum SettingsSections: Int, CaseIterable {
    case name
    case profession
    case age
    case bio
    case ageRange
    
    var description: String {
        switch self {
        case .name: return "Name"
        case .profession: return "Profession"
        case .age: return "Age"
        case .bio: return "Bio"
        case .ageRange: return "Seeking Age Range"
        }
    }
}

struct SettingsViewModel {
    private let user: User
    private let section: SettingsSections
    
    var shouldHideInputField: Bool {
        section == .ageRange
    }
    var shouldHideSlider: Bool {
        section != .ageRange
    }
    
    // MARK: - Lifecycle
    init(user: User, section: SettingsSections) {
        self.user = user
        self.section = section
    }
}
