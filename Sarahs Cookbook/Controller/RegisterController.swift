//
//  RegisterController.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/22/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = ""
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    self.errorLabel.text = err.localizedDescription
                } else {
                    self.errorLabel.text = ""
                    self.performSegue(withIdentifier: K.Routes.homeFromRegister, sender: self)
                }
            }
        }
        
    }
     
}
