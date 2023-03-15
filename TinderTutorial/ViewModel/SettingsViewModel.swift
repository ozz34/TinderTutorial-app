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
    // MARK: - Properties
    let section: SettingsSections
    let placeholderText: String
    var value: String?
    
    private let user: User
    
    var shouldHideInputField: Bool {
        section == .ageRange
    }
    var shouldHideSlider: Bool {
        section != .ageRange
    }
    var minAgeSliderValue: Float {
        Float(user.minSeekingAge)
    }
    var maxAgeSliderValue: Float {
        Float(user.maxSeekingAge)
    }
    
    // MARK: - Lifecycle
    init(user: User, section: SettingsSections) {
        self.user = user
        self.section = section
        placeholderText = "Enter \(section.description.lowercased())..."
        
        switch section {
        case .name:
            value = user.name
        case .profession:
            value = user.profession
        case .age:
            value = "\(user.age)"
        case .bio:
            value = user.bio
        case .ageRange:
                break
        }
    }
    
    // MARK: - Helpers
    func minAgeLabelText(forValue value: Float) -> String {
        "Min: \(Int(value))"
    }
    
    func maxAgeLabelText(forValue value: Float) -> String {
        "Max: \(Int(value))"
    }
}
