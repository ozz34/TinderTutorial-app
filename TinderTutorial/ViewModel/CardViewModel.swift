//
//  CardViewModel.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 01.03.2023.
//

import UIKit

struct CardViewModel {
    let user: User
    let imageURLs: [String]
    let userInfoText: NSAttributedString
    private var imageIndex = 0
    var imageUrl: URL?
    
    init(user: User) {
        self.user = user
        
        let attributedText = NSMutableAttributedString(string: user.name,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy),.foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "  \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24),.foregroundColor: UIColor.white]))
        
        userInfoText = attributedText
        
//        self.imageUrl = URL(string: user.profileImageUrl)
        self.imageURLs = user.imageURLs
        self.imageUrl = URL(string: self.imageURLs[0])
    }
    
    mutating func showNextPhoto() {
//        guard imageIndex < user.images.count - 1 else { return }
//        imageIndex += 1
//        imageToShow = user.images[imageIndex]
    }
    
    mutating func showPreviousPhoto() {
//        guard imageIndex > 0 else { return }
//        imageIndex -= 1
//        self.imageToShow = user.images[imageIndex]
    }
}
