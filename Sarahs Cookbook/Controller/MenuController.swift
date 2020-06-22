//
//  ViewController.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/21/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit
import CLTypingLabel

class MenuController: UIViewController {
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Sarah's Cookbook"
    }


}

