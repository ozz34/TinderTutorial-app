//
//  MatchView.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 13.03.2023.
//

import UIKit

class MatchView: UIView {
    // MARK: - Properties
    private let currentUser: User
    private let matchedUser: User
    
    // MARK: - Lifecycle
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        super.init(frame: .zero)
        
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
