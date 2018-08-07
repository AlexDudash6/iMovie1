//
//  HamburgerButton.swift
//  MoviesLibrary
//
//  Created by Oleksandr O. Dudash on 8/15/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit

class HamburgerButton: UIBarButtonItem {
    
    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        // Creates a bitmap-based graphics context with the specified options.
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        
        //Returns an image based on the contents of the current bitmap-based graphics context.
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        // Removes the current bitmap-based graphics context from the top of the stack
        UIGraphicsEndImageContext()
        
        return defaultMenuImage;
    }
    
    func addSlideMenuButton() -> UIBarButtonItem {
        let menuButton = UIButton(type: UIButtonType.system)
        menuButton.setImage(self.defaultMenuImage(), for: UIControlState())
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        menuButton.tintColor = .white
        let customBarItem = UIBarButtonItem(customView: menuButton)
        return customBarItem
    }
}
