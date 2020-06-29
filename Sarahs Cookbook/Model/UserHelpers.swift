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
}
