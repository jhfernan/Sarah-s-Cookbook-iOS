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
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageOfRecipe: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var votingStar1: UIImageView!
    @IBOutlet weak var votingStar2: UIImageView!
    @IBOutlet weak var votingStar3: UIImageView!
    @IBOutlet weak var votingStar4: UIImageView!
    @IBOutlet weak var votingStar5: UIImageView!
    
    let db = Firestore.firestore()
    
    var recipeId = ""
    var recipeName: String = "name"
    var recipePrepTime: String = "Prep Time: 30 Mins"
    var recipeAuthorUID: String = ""
    var recipeAuthor: String = "By: "
    var recipeImage: UIImage = #imageLiteral(resourceName: "Cookbook Image Alt")
    var recipeIngredients: String = "get this stuff"
    var recipeDirections: String = "do this stuff"
    var recipeRating: Double = 0.0
    var recipeVotes: [String: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.text = ""
        nameLabel.text = recipeName
        prepTimeLabel.text = recipePrepTime
        ratingLabel.text = "\(recipeRating) out of \(recipeVotes.count) Votes"
        imageOfRecipe.image = recipeImage
        authorLabel.text = recipeAuthor
        ingredientsLabel.text = recipeIngredients
        directionsLabel.text = recipeDirections
        star1.image = RecipeHelpers.starRatingLogic(star: 1, rating: recipeRating)
        star2.image = RecipeHelpers.starRatingLogic(star: 2, rating: recipeRating)
        star3.image = RecipeHelpers.starRatingLogic(star: 3, rating: recipeRating)
        star4.image = RecipeHelpers.starRatingLogic(star: 4, rating: recipeRating)
        star5.image = RecipeHelpers.starRatingLogic(star: 5, rating: recipeRating)
        
        
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
    
    @IBAction func starPressed(_ sender: UIButton) {
        if let starNumber = Int(sender.currentTitle!) {
            let newRating = Double(starNumber)
            votingStar1.image = RecipeHelpers.starRatingLogic(star: 1, rating: newRating)
            votingStar2.image = RecipeHelpers.starRatingLogic(star: 2, rating: newRating)
            votingStar3.image = RecipeHelpers.starRatingLogic(star: 3, rating: newRating)
            votingStar4.image = RecipeHelpers.starRatingLogic(star: 4, rating: newRating)
            votingStar5.image = RecipeHelpers.starRatingLogic(star: 5, rating: newRating)
            
            addVoteToList(vote: starNumber)
        }
        
    }
}

//MARK: - Voting Logic
extension RecipeController {
    func addVoteToList(vote: Int) {
        loadingIndicator.startAnimating()
        var newVotes = recipeVotes
        newVotes[Auth.auth().currentUser!.uid] = vote
        db.collection(K.Models.Recipe.collectionName)
        .document(recipeId)
        .updateData(newVotes) { (err) in
            if let err = err {
                self.errorLabel.text = err.localizedDescription
                self.loadingIndicator.stopAnimating()
            } else {
                self.errorLabel.text = ""
                self.loadingIndicator.stopAnimating()
                print("Updated")
            }
        }
    }
}
