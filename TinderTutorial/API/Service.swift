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
    
    static func saveUserData(user: User, completion: @escaping(Error?)-> Void) {
        let data = ["uid": user.uid,
                    "fullname": user.name,
                    "imageURLs": user.imageURLs,
                    "age": user.age,
                    "bio": user.bio,
                    "profession": user.profession,
                    "minSeekingAge": user.minSeekingAge,
                    "maxSeekingAge": user.maxSeekingAge] as [String : Any]
        
        COLLECTION_USERS.document(user.uid).setData(data, completion: completion)
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(forCurrentUser user: User, completion: @escaping([User]) -> Void) {
        var users = [User]()
        
        let query = COLLECTION_USERS.whereField("age", isGreaterThanOrEqualTo: user.minSeekingAge)
                                    .whereField("age", isLessThanOrEqualTo: user.maxSeekingAge)
        query.getDocuments { (snapshot, error) in
            snapshot?.documents.forEach { document in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                
                guard user.uid != Auth.auth().currentUser?.uid else { return }
                users.append(user)
            }
            completion(users)
        }
    }
    
    static func saveSwipe(forUser user: User, isLike: Bool) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
       
        COLLECTION_SWIPES.document(uid).getDocument { (snapshot, error) in
            let data = [user.uid: isLike]
            
            if snapshot?.exists == true {
                COLLECTION_SWIPES.document(uid).updateData(data)
            } else {
                COLLECTION_SWIPES.document(uid).setData(data)
            }
        }
    }
}
