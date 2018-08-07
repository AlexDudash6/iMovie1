//
//  LocalizationManager.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 6/1/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

class LocalizationManager {
    
    static let sharedInstance = LocalizationManager()
    
    private init() {}
    
    lazy var localizableDictionary: NSDictionary! = {
        if let path = Bundle.main.path(forResource: "Localizable", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        fatalError("Localizable file NOT found")
    }()
    
    func localize(_ string: String) -> String {
        guard let localizedString = (localizableDictionary.value(forKey: string) as AnyObject).value(forKey: "value") as? String else {
            assertionFailure("Missing translation for: \(string)")
            return ""
        }
        return localizedString
    }
}

extension String {
    var localized: String {
        return LocalizationManager.sharedInstance.localize(self)
    }
}
