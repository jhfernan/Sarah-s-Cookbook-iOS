//
//  AddRecipeController.swift
//  Sarahs Cookbook
//
//  Created by Jonathan Fernandes on 6/24/20.
//  Copyright © 2020 Jonathan Fernandes. All rights reserved.
//

import UIKit
import Firebase

class AddRecipeController: UIViewController {
    
    @IBOutlet weak var ingredientsTextview: UITextView!
    @IBOutlet weak var directionsTextview: UITextView!
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeImage: UIImageView!
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeImage.image = #imageLiteral(resourceName: "Cookbook Image Alt")
    }
    
    @IBAction func addRecipePressed(_ sender: UIButton) {
        
        if let name = recipeName.text,
            let ingredients = ingredientsTextview.text,
            let directions = directionsTextview.text,
            let userId = Auth.auth().currentUser?.uid {
            var data: [String: Any] = [
                K.Models.Recipe.name: name,
                K.Models.Recipe.author: userId,
                K.Models.Recipe.ingredients: ingredients,
                K.Models.Recipe.directions: directions,
                K.Models.Recipe.createdOn: Date().timeIntervalSince1970
            ]
            if recipeImage.image == #imageLiteral(resourceName: "Cookbook Image Alt") {
                print("Picture was not changed")
                createRecipe(with: data)
            } else {
                let storageRef = storage.reference()
                let imageRef = storageRef.child("recipes/\(userId)/\(name)")
                let imageToUpload = RecipeHelpers.resizeImage(image: recipeImage.image!, newWidth: CGFloat(200))
                if let dataImage = imageToUpload!.pngData() {
                    imageRef.putData(dataImage, metadata: nil) { (metadata, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        
                        imageRef.downloadURL { (url, err) in
                            guard let downloadedURL = url else {
                                print(err!)
                                return
                            }
                            data[K.Models.Recipe.imagePath] = downloadedURL.absoluteString
                            self.createRecipe(with: data)
                        }
                    }
                }
            }
        }
    }
    
    func createRecipe(with data: [String: Any]) {
        db.collection(K.Models.Recipe.collectionName).addDocument(data: data) { (error) in
            if let err = error {
                print("Issue encountered trying to push data to database: \(err)")
            } else {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func imagePressed(_ sender: UIButton) {
        pickImage()
    }
}


//MARK: - UIImagePickerController

extension AddRecipeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled picker")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] {
            selectedImageFromPicker = editedImage as? UIImage
        } else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] {
            selectedImageFromPicker = originalImage as? UIImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            recipeImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
