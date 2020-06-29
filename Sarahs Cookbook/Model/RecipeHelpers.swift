//
//  RecipeData.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/21/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit

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
}
