//
//  MatchCellViewModel.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 14.03.2023.
//

import UIKit

struct MatchCellViewModel {
    
    let nameText: String
    var profileImageUrl: URL?
    let uid: String
    
    init(match: Match) {
        nameText = match.name
        self.profileImageUrl = URL(string: match.profileImageUrl)
        uid = match.uid
    }
}
