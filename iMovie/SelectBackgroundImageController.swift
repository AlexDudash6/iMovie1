//
//  SelectBackgroundImageController.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 5/2/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

class SelectImageController: UIViewController {
   
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var imagesArray : [UIImage] = []
    let userDefaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imagesArray =  Constants.appImages
        view.backgroundColor = UIColor(patternImage: userDefaults.imageForKey(key: Constants.UserDefaultKeys.AppBackground.rawValue) ?? #imageLiteral(resourceName: "patternMovie"))
    }
}
