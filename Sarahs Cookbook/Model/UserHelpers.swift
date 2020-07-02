//
//  UserHelpers.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/29/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit
import Firebase

struct UserHelpers {
    
    static func updateUserData(for userId: String?, with data: [String: Any]) {
        let db = Firestore.firestore()
        if let uid = userId {
            db.collection("users")
                .document(uid)
                .setData(data) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
    static func updateProfile(email: String, displayName: String, completion: @escaping (Res?)->()) {
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        
        if email != "" && displayName == "" {
            user?.updateEmail(to: email) { (error) in
                if let err = error {
                    completion(Res(err: err.localizedDescription, message: nil))
                }
                completion(Res(err: nil, message: email))
            }
        } else if email == "" && displayName != "" {
            db.collection("users")
                .document(user!.uid)
                .setData(["displayName": displayName]) { err in
                if let err = err {
                    completion(Res(err: err.localizedDescription, message: nil))
                } else {
                    completion(Res(err: nil, message: displayName))
                }
            }
        } else if email != "" && displayName != "" {
            user?.updateEmail(to: email) { (error) in
                if let err = error {
                    completion(Res(err: err.localizedDescription, message: nil))
                }
                db.collection("users")
                    .document(user!.uid)
                    .setData(["displayName": displayName]) { err in
                    if let err = err {
                        completion(Res(err: err.localizedDescription, message: nil))
                    } else {
                        completion(Res(err: nil, message: displayName))
                    }
                }
            }
        }
    }
}

struct Res {
    let err: String?
    let message: String?
}
