//
//  LoginController+PatternLock.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 2/20/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import OXPatternLock
import SwiftSpinner

extension LoginViewController: OXPatternLockDelegate {
    
    func didPatternInput(patterLock: OXPatternLock, track: [Int]) {
        var password: [Int] = []
        if let passwordFromDefaults = userDefaults.value(forKeyPath: kSavedPassword) as? [Int] {
            password = passwordFromDefaults
        }
        
        if (savedTrackPath.isEmpty && password.isEmpty) {
            savedTrackPath = track
            SwiftSpinner.show("Saving pattern..")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                SwiftSpinner.hide()
                self.dismiss(animated: true, completion: nil)
            })
            userDefaults.set(savedTrackPath, forKey: kSavedPassword)
            
        } else {
            if track == password {
                SwiftSpinner.show("Authenticating user..")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    SwiftSpinner.hide()
                    if !self.launchedBefore {
                        self.performSegue(withIdentifier: "goToHomePage", sender: Any?.self)
                    } else {
                        self.animateIn()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                            self.animateOut()
                        })
                    }
                })
                
            } else {
                addAlert()
            }
        }
    }
    
}
