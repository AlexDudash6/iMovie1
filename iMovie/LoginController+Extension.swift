//
//  LoginController+Extension.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/27/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import CDAlertView

extension LoginViewController: Alertable {
    
    func addAlert() {
        let alert = CDAlertView(title: "Wrong Password", message: "", type: .warning)
        let tryAgainAction = CDAlertViewAction(title: "Try again")
        alert.add(action: tryAgainAction)
        alert.show()
    }
}
