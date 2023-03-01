//
//  CardViewModel.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 01.03.2023.
//

import UIKit

struct CardViewModel {
    let user: User
    let userInfoText: NSAttributedString
    private var imageIndex = 0
    var imageToShow: UIImage?
    
    init(user: User) {
        self.user = user
        
        let attributedText = NSMutableAttributedString(string: user.name,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy),.foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "  \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24),.foregroundColor: UIColor.white]))
        
        userInfoText = attributedText
    }
    
    mutating func showNextPhoto() {
        guard imageIndex < user.images.count - 1 else { return }
        imageIndex += 1
        imageToShow = user.images[imageIndex]
    }
    
    mutating func showPreviousPhoto() {
        guard imageIndex > 0 else { return }
        imageIndex -= 1
        self.imageToShow = user.images[imageIndex]
    }
}
