//
//  SearchResponseController+Extensions.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 8/7/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import CDAlertView

extension SearchResponseController: Alertable {
   
    func addAlert() {
        let alert = CDAlertView(title: "Something went wrong", message: "", type: .warning)
        let tryAgainAction = CDAlertViewAction(title: "Try again")
        alert.add(action: tryAgainAction)
        alert.show()
    }
    
}
