//
//  MAGlowingLabel.swift
//  MAGlowingLabel


import UIKit

class MAGlowingLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGlowingEffect();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addGlowingEffect()
    }
    
    func addGlowingEffect()  {
        let labelTransparency = 0.5
        let labelWidth = self.frame.size.width
        
        let glowSize = 40 / labelWidth
        
        let startingLocations = [NSNumber.init(value:0.0), NSNumber.init(value:((Float)(glowSize / 2))),NSNumber.init(value:((Float)(glowSize)/1))]
        
        let endingLocations = [(1.0 - glowSize), (1.0 - (glowSize / 2)), 1.0] as NSArray
        
        let animation :CABasicAnimation = CABasicAnimation(keyPath: "locations")
        let glowMask:CAGradientLayer = CAGradientLayer.init()
        glowMask.frame = self.bounds
        
        let gradient = UIColor.init(white: 0.5, alpha: CGFloat(labelTransparency))
        glowMask.colors =  [gradient.cgColor,UIColor.white
            .cgColor,gradient.cgColor]
        glowMask.locations = startingLocations 
        
        glowMask.startPoint = CGPoint(x: 0 - (glowSize * 2), y: 1)
        glowMask.endPoint = CGPoint(x: 1 + glowSize , y: 1)
        self.layer.mask = glowMask
        
        animation.fromValue = startingLocations
        animation.toValue = endingLocations
        animation.repeatCount = Float.infinity
        animation.duration = 1.5
        animation.isRemovedOnCompletion = false
        glowMask.add(animation, forKey: "gradientAnimation")
    }
}
