//
//  MatchViewViewModel.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 14.03.2023.
//

import Foundation

struct MatchViewViewModel {
    // MARK: - Properties
    let matchedUser: User
    let matchLabelText: String
    var currentUserImageUrl: URL?
    var matchedUserImageUrl: URL?
    
    private let currentUser: User
    
    // MARK: - Lifecycle
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        
        matchLabelText = "You and \(matchedUser.name) have liked each other!"
        
        guard let currentImageURLString = currentUser.imageURLs.first else { return }
        guard let matchedImageURLString = matchedUser.imageURLs.first else { return }
        currentUserImageUrl = URL(string: currentImageURLString)
        matchedUserImageUrl = URL(string: matchedImageURLString)
    }
}
