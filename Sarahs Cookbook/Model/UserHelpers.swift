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
    
    static func getTitle(from user: User?) -> String {
        if let displayName = user?.displayName {
            return displayName
        } else if let email = user?.email {
            return email
        } else {
            return "Profile Page"
        }
    }
    
    static func setUserData(with user: User?) {
        let db = Firestore.firestore()
        if let email = user?.email, let uid = user?.uid {
            db.collection("users").document(uid)
                .setData(["email": email]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
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
}
