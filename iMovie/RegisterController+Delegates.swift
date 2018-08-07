//
//  RegisterController+Delegates.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 12/28/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit

extension RegisterController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
    func handleTap() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImage : UIImage?
        
        if let editedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = originalImage
        }
        
        if let selectedImageFromPicker = selectedImage {
            profileImage.image = selectedImageFromPicker
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
