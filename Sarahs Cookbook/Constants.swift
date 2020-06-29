//
//  Constants.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/22/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

struct K {
    static let appName = "Sarah's Cookbook"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "RecipeCell"
    
    struct FirebaseStorage {
        static let uploadUrlBase = "gs://sarah-s-cookbook.appspot.com/"
    }
    
    struct Routes {
        static let homeFromRegister = "RegisterToHome"
        static let homeFromLogin = "LogInToHome"
        static let recipesFromAdd = "AddToRecipes"
        static let recipesFromDetail = "DetailToRecipes"
        static let detailFromRecipes = "ShowRecipe"
    }
    
    struct Models {
        struct Recipe {
            static let collectionName = "recipes"
            static let name = "name"
            static let author = "user_uid"
            static let ingredients = "ingredients"
            static let directions = "directions"
            static let createdOn = "createdAt"
            static let imagePath = "path"
        }
    }
}
