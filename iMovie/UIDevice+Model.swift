//
//  UIDevice+Model.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 5/3/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
         case "iPhone3,1", "iPhone3,2", "iPhone3,3", "iPhone4,1", "iPhone5,1", "iPhone5,2", "iPhone5,3", "iPhone5,4", "iPhone6,1", "iPhone6,2", "iPhone7,2", "iPhone8,1", "iPhone7,1", "iPhone9,1", "iPhone9,3", "iPhone8,4":     return "Normal"
        
        
         case "iPhone8,2", "iPhone9,2", "iPhone9,4", "i386", "x86_64"  :     return "Plus"
        
        
         default:     return identifier
        }
    }
}
