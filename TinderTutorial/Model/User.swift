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
    var imageURLs: [String]
    let uid: String
    var profession: String
    var minSeekingAge: Int
    var maxSeekingAge: Int
    var bio: String

    init(dictionary: [String: Any]) {
        self.name = dictionary["fullname"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.email = dictionary["email"] as? String ?? ""
        self.imageURLs = dictionary["imageURLs"] as? [String] ?? [String]()
        self.uid = dictionary["uid"] as? String ?? ""
        self.profession = dictionary["profession"] as? String ?? ""
        self.minSeekingAge = dictionary["minSeekingAge"] as? Int ?? 18
        self.maxSeekingAge = dictionary["maxSeekingAge"] as? Int ?? 40
        self.bio = dictionary["bio"] as? String ?? ""
    }
}
