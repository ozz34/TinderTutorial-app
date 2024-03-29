//
//  CardViewModel.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 01.03.2023.
//

import UIKit

struct CardViewModel {
    // MARK: - Properties
    let user: User
    let imageURLs: [String]
    let userInfoText: NSAttributedString
    var imageUrl: URL?
    
    private var imageIndex = 0
    
    var index: Int {
        imageIndex
    }

    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        imageURLs = user.imageURLs
        
        let attributedText = NSMutableAttributedString(string: user.name,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy), .foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "  \(user.age)", attributes:
            [.font: UIFont.systemFont(ofSize: 24), .foregroundColor: UIColor.white]))
        
        userInfoText = attributedText
        imageUrl = URL(string: imageURLs[0])
    }
    
    // MARK: - Helpers
    mutating func showNextPhoto() {
        guard imageIndex < imageURLs.count - 1 else { return }
        imageIndex += 1
        imageUrl = URL(string: imageURLs[imageIndex])
    }
    
    mutating func showPreviousPhoto() {
        guard imageIndex > 0 else { return }
        imageIndex -= 1
        imageUrl = URL(string: imageURLs[imageIndex])
    }
}
