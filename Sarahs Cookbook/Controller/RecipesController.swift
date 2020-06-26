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
    let db = Firestore.firestore()
    
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
        
        
        db.collection(K.Models.Recipe.collectionName)
            .addSnapshotListener() { (querySnapshot, error) in
                
                self.recipes = []
                
                if let err = error {
                    print("Error getting documents: \(err)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let name = data[K.Models.Recipe.name] as? String,
                            let ingredients = data[K.Models.Recipe.ingredients] as? String,
                            let directions = data[K.Models.Recipe.directions] as? String,
                            let createdAt = data[K.Models.Recipe.createdOn] as? Double {
                                let newRecipe = Recipe(name: name, ingredients: ingredients, directions: directions, createdAt: createdAt)
                                self.recipes.append(newRecipe)
                                
                                DispatchQueue.main.async {
                                    self.recipesTable.reloadData()
                                }
                                
                            }
                        }
                    }
                }
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
            destinationVC.recipeName = recipe!.name
            destinationVC.recipeIngredients = recipe!.ingredients
            destinationVC.recipeDirections = recipe!.directions
        }
    }
}
