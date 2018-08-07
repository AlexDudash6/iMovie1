//
//  PDFCreator+Delegates.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/2/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import CircleMenu

extension PDFCreatorController: UIDocumentInteractionControllerDelegate, CircleMenuDelegate {
    
    
    // MARK: - Documents Interaction Controller Delegate
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navController = navigationController else { return self }
        navController.navigationBar.barTintColor = self.navigationController?.navigationBar.barTintColor
        return navController
    }
    
    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.view
    }
    
    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return self.view.frame
    }
    
    func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
        self.view.tintColor = .clear
    }
    
    
    // MARK: - Circle Menu Delegate
    
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        if atIndex == 0 {
            dismiss(animated: true, completion: nil)
        } else if atIndex == 1 {
            docController.presentPreview(animated: true)
        } else {
            presentActivityController()
        }
        
    }
    
}
