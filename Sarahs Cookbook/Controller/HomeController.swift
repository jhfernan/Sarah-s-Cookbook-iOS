//
//  HomeController.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/22/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func easterEggPressed(_ sender: UIButton) {
        if backgroundImage.image != UIImage(named: "MainBGEasterEgg") {
            backgroundImage.image = UIImage(named: "MainBGEasterEgg")
        } else {
            backgroundImage.image = UIImage(named: "MainBG")
        }
    }
}
