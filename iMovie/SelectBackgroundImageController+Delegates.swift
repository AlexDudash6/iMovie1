//
//  SelectBackgroundImageController+Extension.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 5/2/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

extension SelectImageController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        
        cell.imageView.image = imagesArray[indexPath.row]
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = imagesArray[indexPath.row]
        userDefaults.setImage(image: image, forKey: Constants.UserDefaultKeys.AppBackground.rawValue)
        dismiss(animated: true, completion: nil)
    }
}
