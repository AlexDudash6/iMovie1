//
//  MovableButton.swift
//  MoviesLibrary
//
//  Created by Oleksandr O. Dudash on 8/15/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setButtonSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setButtonSettings()
    }
    
    func setButtonSettings() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
}
