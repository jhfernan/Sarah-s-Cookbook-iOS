//
//  ProfileController.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/29/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = UserHelpers.getTitle(from: user)
    }
}
