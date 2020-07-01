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
    
    let db = Firestore.firestore()
    
    var recipeName: String = "name"
    var recipeAuthorUID: String = ""
    var recipeAuthor: String = "By: "
    var recipeImage: UIImage = #imageLiteral(resourceName: "Cookbook Image Alt")
    var recipeIngredients: String = "get this stuff"
    var recipeDirections: String = "do this stuff"
    var recipeRating: Double = 0.0
    var recipeVotes: [String: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = recipeName
        imageOfRecipe.image = recipeImage
        authorLabel.text = recipeAuthor
        ingredientsLabel.text = recipeIngredients
        directionsLabel.text = recipeDirections
        
        if recipeAuthorUID != "" {
            db.collection(K.Models.Users.collectionName)
                .document(recipeAuthorUID)
                .getDocument { (document, error) in
                    if let document = document {
                        if let displayName = document[K.Models.Users.name] as? String {
                            self.authorLabel.text! += displayName
                        }
                        
                    } else {
                        print("No User info found with that id")
                        self.authorLabel.text! += "Anonymous"
                    }
            }
        }
    }
    
    
}
