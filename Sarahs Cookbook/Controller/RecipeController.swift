//
//  RecipeController.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/24/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit
import Firebase

class RecipeController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageOfRecipe: UIImageView!
    
    var recipeName: String = "name"
    var recipeImage: UIImage = #imageLiteral(resourceName: "Cookbook Image Alt")
    var recipeIngredients: String = "get this stuff"
    var recipeDirections: String = "do this stuff"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = recipeName
        imageOfRecipe.image = recipeImage
    }
     
}
