//
//  CollectionCell+Animation.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 3/12/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation


let animationRotateDegres: CGFloat = 0.5
let animationTranslateX: CGFloat = 1.0
let animationTranslateY: CGFloat = 1.0
let count: Int = 1
var transform: CGAffineTransform?

extension UICollectionViewCell {
    
    func stopWiggle() {
        self.layer.removeAllAnimations()
    }
    
    func shake() {
        let leftOrRight: CGFloat = (count % 2 == 0 ? 1 : -1)
        let rightOrLeft: CGFloat = (count % 2 == 0 ? -1 : 1)
        let leftWobble: CGAffineTransform = CGAffineTransform(rotationAngle: degreesToRadians(x: animationRotateDegres * leftOrRight))
        let rightWobble: CGAffineTransform = CGAffineTransform(rotationAngle: degreesToRadians(x: animationRotateDegres * rightOrLeft))
        let moveTransform: CGAffineTransform = leftWobble.translatedBy(x: -animationTranslateX, y: -animationTranslateY)
        let conCatTransform: CGAffineTransform = leftWobble.concatenating(moveTransform)
        
        transform = rightWobble
        
        UIView.animate(withDuration: 0.1, delay: 0.08, options: [.allowUserInteraction, .repeat, .autoreverse], animations: { () -> Void in
            self.transform = conCatTransform
        }, completion: nil)
    }
    
    func degreesToRadians(x: CGFloat) -> CGFloat {
        return CGFloat(Double.pi) * x / 180.0
    }

}
