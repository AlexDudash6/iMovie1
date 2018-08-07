//
//  BlurManager.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 8/3/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

class BlurManager {
    
    static let sharedManager = BlurManager()
    
    private init() {}
    
    func setBlur(withTag tag: Int, view: UIView) -> UIView {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = tag
       
        return blurEffectView
    }
    
    func removeBlur(withTag tag: Int, view: UIView) {
        if let blurHugeView = view.viewWithTag(tag) {
            blurHugeView.removeFromSuperview()
        } else { return }
    }
    
}
