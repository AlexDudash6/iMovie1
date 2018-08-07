//
//  LaunchScreenController.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 2/22/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    
    // MARK: - Properties
    
    let userDefaults = UserDefaults.standard
    let kLaunchedBefore = Constants.UserDefaultKeys.LaunchedBefore.rawValue
    
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
       
        animateLaunchScreen()
    }
    
    
    // MARK: - Helper
    
    func animateLaunchScreen() {
        let launchedBefore = userDefaults.bool(forKey: kLaunchedBefore)
        
        let animationView = LOTAnimationView(name: "video_cam")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = self.view.center
        
        animationView.loopAnimation = false
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 0.7
        
        // Applying UIView animation
        let minimizeTransform = CGAffineTransform(scaleX: 0.99, y: 0.99)
        animationView.transform = minimizeTransform
        UIView.animate(withDuration: 3.0, delay: 0.0, options: [.autoreverse], animations: {
            animationView.transform = CGAffineTransform.identity
        }, completion: { (success) in
            if launchedBefore {
                self.performSegue(withIdentifier: "goToLogin", sender: self)
            } else {
                self.userDefaults.set(true, forKey: self.kLaunchedBefore)
                self.performSegue(withIdentifier: "goToRegister", sender: self)
            }
        })
        
        view.addSubview(animationView)
        animationView.play()
    }
}

