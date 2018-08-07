//
//  ColorScheme.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 3/2/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

class ColorScheme {
    
    static let sharedInstance = ColorScheme()
    
    func setColor(for viewController: UIViewController) {
        viewController.navigationController?.navigationBar.backgroundColor = .black
        viewController.navigationController?.navigationBar.tintColor = UIColor(hexString: "#FFC107")
        viewController.view.backgroundColor = UIColor(hexString: "#263238")
        for subview in viewController.view.subviews {
            subview.backgroundColor = UIColor(hexString: "#263238")
        }
    }
}
