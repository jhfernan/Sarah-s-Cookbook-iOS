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
        setTitle()
    }
    
    @IBAction func updateProfilePressed(_ sender: UIButton) {
        loadingIndicator.isHidden = false
        if emailTextfield.text != "" {
            let email = emailTextfield.text
            user?.updateEmail(to: email!) { (error) in
                if let err = error {
                    self.errorLabel.text = err.localizedDescription
                }
                self.setTitle()
                UserHelpers.updateUserData(for: self.user?.uid, with: ["email": email!])
                
                self.emailTextfield.text = ""
            }
        }
        
        if displayNameTextfield.text != "" {
            let displayName = displayNameTextfield.text
            let updateRequest = user?.createProfileChangeRequest()
            updateRequest?.displayName = displayName
            updateRequest?.commitChanges { (error) in
                if let err = error {
                    self.errorLabel.text = err.localizedDescription
                }
                self.setTitle()
                UserHelpers.updateUserData(for: self.user?.uid, with: ["displayName": displayName!])
                
                self.displayNameTextfield.text = ""
            }
        }
    }
    
    func setTitle() {
        title = UserHelpers.getTitle(from: user)
    }
}
