//
//  RecipeData.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/21/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit
import Firebase

struct RecipeHelpers {
    
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    static func starRatingLogic(star: Int, rating: Double) -> UIImage {
        var response: UIImage = UIImage(systemName: "star")!
        switch star {
        case 1:
        if rating >= Double(star) {
            response = UIImage(systemName: "star.fill")!
        }
        case 2:
        if rating >= Double(star) {
            response = UIImage(systemName: "star.fill")!
        }
        case 3:
        if rating >= Double(star) {
            response = UIImage(systemName: "star.fill")!
        }
        case 4:
        if rating >= Double(star) {
            response = UIImage(systemName: "star.fill")!
        }
        case 5:
        if rating >= Double(star) {
            response = UIImage(systemName: "star.fill")!
        }
        default:
            response = UIImage(systemName: "star")!
        }
        return response
    }
    
}
