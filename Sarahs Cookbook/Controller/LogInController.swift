//
//  LogInController.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/22/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit
import Firebase

class LogInController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = ""
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            loadingIndicator.startAnimating()
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    // Search FIRAuthErrors and make switch statement for different error codes
                    self.errorLabel.text = err.localizedDescription
                    self.loadingIndicator.stopAnimating()
                } else {
                    self.errorLabel.text = ""
                    self.loadingIndicator.stopAnimating()
                    self.performSegue(withIdentifier: K.Routes.homeFromLogin, sender: self)
                }
            }
        }
    }
}
