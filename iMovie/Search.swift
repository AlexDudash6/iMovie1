//
//  Search.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 3/7/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

class SearchCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var imageCoverView: UIView!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        // 1
        let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
        let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
        
        // 2
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
        // 3
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
    }
}
