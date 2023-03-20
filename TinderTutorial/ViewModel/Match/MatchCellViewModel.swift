//
//  MatchCellViewModel.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 14.03.2023.
//

import Foundation

struct MatchCellViewModel {
    // MARK: - Properties
    let nameText: String
    var profileImageUrl: URL?
    let uid: String

    // MARK: - Lifecycle
    init(match: Match) {
        nameText = match.name
        profileImageUrl = URL(string: match.profileImageUrl)
        uid = match.uid
    }
}
