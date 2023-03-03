//
//  Service.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 03.03.2023.
//

import Firebase
import FirebaseStorage

struct Service {
    static func uploadImage(image: UIImage, completion: @escaping(String)-> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.7) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(fileName)")
        
        ref.putData(imageData) { (meta, error) in
            if let error {
                print("Debug: Error upload image \(error.localizedDescription)")
                return
            }
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            print(snapshot?.data())
        }
    }
}
