//
//  Service.swift
//  TinderClone
//
//  Created by MacBook on 21/07/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import Firebase

struct Service {
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)  
        }
    }
    static func fetchUsers(completion: @escaping([User]) -> Void){
        var users = [User]()
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
//                if users.count == snapshot?.documents.count {
//                    completion(user)
//                }
            })
        }
    }
    static func saveUserData(user: User,completion: @escaping(Error?) -> Void) {
        let data = ["uid": user.uid,
                    "fullname": user.name,
            "imageUrls": user.imageURLs,
            "age": user.age,
            "bio": user.bio,
            "profession": user.profession,
            "minSeekingAge": user.minSeekingAge,
            "maxSeekingAge": user.maxSeekingAge
            ] as [String : Any]
        COLLECTION_USERS.document(user.uid).setData(data,completion: completion)
    }
    static func uploadImage(image: UIImage,completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        ref.putData(imageData, metadata: nil){
            (metadata, error) in
            if let error = error {
                print("DEBUG: Error uploading image \(error.localizedDescription)")
                return
            }
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
    }
}
