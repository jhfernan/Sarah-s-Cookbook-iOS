//
//  Recipe.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/26/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit

struct Recipe {
    let name: String
    let user_uid: String
    let cookTime: String
    var image: UIImage? = nil
    let ingredients: String
    let directions: String
    let createdAt: Double
    var path: String = ""
    
    init(info: [String: Any]) {
        self.name = info["name"] as! String
        self.user_uid = info["user_uid"] as! String
        self.cookTime = info["cookTime"] as! String
        self.ingredients = info["ingredients"] as! String
        self.directions = info["directions"] as! String
        self.createdAt = info["createdAt"] as! Double
        if let path = info["path"] {
            self.path = path as! String
        }
        if let image = info["image"] {
            self.image = image as? UIImage
        }
        
    }
}
