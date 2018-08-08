//
//  MovieCell.swift
//  MoviesLibrary
//
//  Created by Oleksandr O. Dudash on 8/15/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var movieTitle: MAGlowingLabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var blur: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate: EditableCollection!
    var index: IndexPath!
    
    @IBAction func deleteCell(_ sender: UIButton) {
        delegate.deleteItem(withIndex: index.row)
    }
    
}
