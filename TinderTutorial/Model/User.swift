//
//  User.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 01.03.2023.
//

import Foundation

struct User {
    var name: String
    var age: Int
    var email: String
    let profileImageUrl: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["fullname"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["imageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
     }
}
