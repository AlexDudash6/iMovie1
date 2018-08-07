//
//  UIColor+Extension.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/2/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

extension UIColor {
    static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(
            red: 1.0 / 255.0 * CGFloat(red),
            green: 1.0 / 255.0 * CGFloat(green),
            blue: 1.0 / 255.0 * CGFloat(blue),
            alpha: CGFloat(alpha))
    }
}
