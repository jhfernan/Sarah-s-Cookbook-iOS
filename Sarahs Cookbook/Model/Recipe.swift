//
//  Recipe.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/26/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit

struct Recipe {
    let rid: String
    let name: String
    let user_uid: String
    let cookTime: String
    var image: UIImage? = nil
    let ingredients: String
    let directions: String
    let createdAt: Double
    var path: String = ""
    let votes: [String: Int]
    var rating: Double {
        get {
            let total = votes.reduce(0) { (total, item) -> Int in
                return total + item.value
            }
            return Double(total) / Double(votes.count)
        }
    }
    
    init(info: [String: Any]) {
        self.rid = info[K.Models.Recipe.id] as! String
        self.name = info[K.Models.Recipe.name] as! String
        self.user_uid = info[K.Models.Recipe.author] as! String
        self.cookTime = info[K.Models.Recipe.time] as! String
        self.ingredients = info[K.Models.Recipe.ingredients] as! String
        self.directions = info[K.Models.Recipe.directions] as! String
        self.createdAt = info[K.Models.Recipe.createdOn] as! Double
        self.votes = info[K.Models.Recipe.usersWhoVoted] as! [String: Int]
        if let path = info[K.Models.Recipe.imagePath] {
            self.path = path as! String
        }
        if let image = info["image"] {
            self.image = image as? UIImage
        }
        
    }
}
