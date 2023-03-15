//
//  ProfileViewModel.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 12.03.2023.
//

import UIKit

struct ProfileViewModel {
    // MARK: - Properties
    let userDetailsAttributedString: NSAttributedString
    let profession: String
    let bio: String
    
    private let user: User
   
    var imageCount: Int {
        user.imageURLs.count
    }
    var imageURLs: [URL?] {
        user.imageURLs.map {URL(string: $0)}
    }
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        
        let attributedText = NSMutableAttributedString(string: user.name,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .semibold)])
        attributedText.append(NSAttributedString(string: "  \(user.age)",
                                                 attributes: [.font: UIFont.systemFont(ofSize: 22)]))
        userDetailsAttributedString = attributedText
        
        profession = user.profession
        bio = user.bio
    }
}
