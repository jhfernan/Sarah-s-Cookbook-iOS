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
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var displayNameTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = ""
    }
    
    @IBAction func updateProfilePressed(_ sender: UIButton) {
        loadingIndicator.startAnimating()
        UserHelpers.updateProfile(email: emailTextfield.text!, displayName: displayNameTextfield.text!) { (res) in
            if let err = res!.err {
                self.errorLabel.text = err
                self.loadingIndicator.stopAnimating()
            } else {
                self.title = res?.title
                self.loadingIndicator.stopAnimating()
            }
        }
    }
}
