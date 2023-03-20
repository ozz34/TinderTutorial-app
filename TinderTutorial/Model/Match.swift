//
//  Match.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 14.03.2023.
//

import Foundation

struct Match {
    let name: String
    let profileImageUrl: String
    let uid: String

    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
