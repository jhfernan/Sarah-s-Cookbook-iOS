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
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var directionsLabel: UILabel!
    
    var recipeName: String = "name"
    var recipeAuthor: String = "By: Anonymous"
    var recipeImage: UIImage = #imageLiteral(resourceName: "Cookbook Image Alt")
    var recipeIngredients: String = "get this stuff"
    var recipeDirections: String = "do this stuff"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = recipeName
        imageOfRecipe.image = recipeImage
        authorLabel.text = recipeAuthor
        ingredientsLabel.text = recipeIngredients
        directionsLabel.text = recipeDirections
    }
    
    
}
