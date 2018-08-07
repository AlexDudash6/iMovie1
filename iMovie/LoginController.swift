//
//  LoginController.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 2/16/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import CDAlertView
import OXPatternLock
import CoreData

class LoginViewController: UIViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet var patternLock: OXPatternLock!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var usernameLabel: MAGlowingLabel!
    @IBOutlet weak var greetingView: UIView!
    
    var savedTrackPath: [Int] = []
    var users: [NSManagedObject] = []
    let userDefaults = UserDefaults.standard
    let kSavedPassword = Constants.UserDefaultKeys.SavedPassword.rawValue
    var effect: UIVisualEffect!
    let kLaunchedBefore = Constants.UserDefaultKeys.LaunchedBefore.rawValue
    var launchedBefore = false
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        patternLock.delegate = self
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        visualEffectView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        launchedBefore = userDefaults.bool(forKey: kLaunchedBefore)
    }
    
    
    // MARK: - Helpers
    
    func animateIn() {
        users = CoreDataManager.sharedInstance.fetchUser()
        fetchUsersName()
        
        visualEffectView.isHidden = false

        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.greetingView.alpha = 1
            self.greetingView.transform = CGAffineTransform.identity
        }
    }

    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.greetingView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.greetingView.alpha = 0
        }) { (success:Bool) in
            self.performSegue(withIdentifier: "goToHomePage", sender: Any?.self)
        }
    }

    func fetchUsersName() {
        let user = users[0]
        guard let username = user.value(forKey: "username") as? String else {
            return
        }
        usernameLabel.text = username
    }
 
}
