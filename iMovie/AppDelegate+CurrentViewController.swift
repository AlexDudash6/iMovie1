//
//  UIViewController+CurrentViewController.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/11/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func findCurrentViewController() -> UIViewController {
        let vc = MoviesCollection()
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            return findCurrentViewController(byTempTopVC: rootVC)
        }
        return vc
    }
    
    func findCurrentViewController(byTempTopVC vc: UIViewController) -> UIViewController {
        let presentedVC = vc.presentedViewController
        guard presentedVC != nil else { return vc }
        
        if presentedVC is UINavigationController {
            let theNav =  presentedVC
            let theTopVC = theNav!.childViewControllers.last
            return findCurrentViewController(byTempTopVC: theTopVC!)
        }
        
        return findCurrentViewController(byTempTopVC: presentedVC!)
    }
}


extension UIApplication {
    
    func findCurrentViewController() -> UIViewController {
        let vc = MoviesCollection()
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            return findCurrentViewController(byTempTopVC: rootVC)
        }
        return vc
    }
    
    func findCurrentViewController(byTempTopVC vc: UIViewController) -> UIViewController {
        let presentedVC = vc.presentedViewController
        
        guard presentedVC != nil else { return vc }
        
        if presentedVC is UINavigationController {
            let theNav =  presentedVC
            let theTopVC = theNav!.childViewControllers.last
            return findCurrentViewController(byTempTopVC: theTopVC!)
        }
        
        return findCurrentViewController(byTempTopVC: presentedVC!)
    }
}



