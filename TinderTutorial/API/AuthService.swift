//
//  AuthService.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 03.03.2023.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let fullName: String
    let password: String
    let profileImage: UIImage
}

struct AuthService {
    static func logUserIn(withEmail email: String,
                          password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping ((Error?) -> Void)) {
        Service.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (results, error) in
                if let error {
                    print("Debug: Error signing user up \(error.localizedDescription)")
                    return
                }
                guard let uid = results?.user.uid else { return }
                
                let data = ["email": credentials.email,
                            "fullname": credentials.fullName,
                            "imageUrl": imageUrl,
                            "uid": uid,
                            "age": 18] as [String: Any]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
    }
}


