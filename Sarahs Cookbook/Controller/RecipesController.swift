//
//  RecipesController.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/24/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit
import Firebase

class RecipesController: UIViewController {
    
    @IBOutlet weak var recipesTable: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var recipes: [Recipe] = []
    var recipe: Recipe? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesTable.delegate = self
        recipesTable.dataSource = self
        recipesTable.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadRecipes()
    }
    
    func loadRecipes() {
        db.collection(K.Models.Recipe.collectionName).addSnapshotListener() { (querySnapshot, error) in
            self.recipes = []
            
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let name = data[K.Models.Recipe.name] as? String,
                            let author = data[K.Models.Recipe.author] as? String,
                            let time = data[K.Models.Recipe.time] as? String,
                            let ingredients = data[K.Models.Recipe.ingredients] as? String,
                            let directions = data[K.Models.Recipe.directions] as? String,
                            let createdAt = data[K.Models.Recipe.createdOn] as? Double {
                            var info: [String: Any] = [
                                K.Models.Recipe.name: name,
                                K.Models.Recipe.author: author,
                                K.Models.Recipe.time: time,
                                K.Models.Recipe.ingredients: ingredients,
                                K.Models.Recipe.directions: directions,
                                K.Models.Recipe.createdOn: createdAt
                            ]
                            if let path = data[K.Models.Recipe.imagePath] as? String {
                                info[K.Models.Recipe.imagePath] = path
                                
                                let recipeRef = self.storage.reference(forURL: path)
                                
                                recipeRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                    if let error = error {
                                        print(error)
                                    } else {
                                        info["image"] = UIImage(data: data!)
                                        self.updateRecipes(with: info)
                                    }
                                }
                            } else {
                                self.updateRecipes(with: info)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateRecipes(with info: [String: Any]) {
        let newRecipe = Recipe(info: info)
        recipes.append(newRecipe)
        
        DispatchQueue.main.async {
            self.recipesTable.reloadData()
            self.loadingIndicator.stopAnimating()
        }
    }
    
}

extension RecipesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! RecipeCell
        cell.nameLabel.text = recipe.name
        
        if recipe.image != nil {
            cell.recipeImage.image = recipe.image
        }
        
        return cell
    }
    
    
}

extension RecipesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe = recipes[indexPath.row]
        self.performSegue(withIdentifier: K.Routes.detailFromRecipes, sender: self)
    }
}

extension RecipesController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Routes.detailFromRecipes {
            let destinationVC = segue.destination as! RecipeController
            print(recipe!.user_uid)
            
            db.collection(K.Models.Users.collectionName)
                .document(recipe!.user_uid)
                .getDocument { (document, error) in
                    if let document = document {
                        let data = document.data()
                        if let displayName = data[K.Models.Users.name] {
                            destinationVC.recipeAuthor = "By: \(displayName)"
                        }
                        
                    } else {
                        print("No User info found with that id")
                    }
            }
            
            destinationVC.recipeName = recipe!.name
            destinationVC.recipeIngredients = recipe!.ingredients
            destinationVC.recipeDirections = recipe!.directions
            if let image = recipe?.image {
                destinationVC.recipeImage = image
            }
        }
    }
}
