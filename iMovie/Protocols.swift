//
//  Protocols.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/10/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

protocol Shareble {
    func urlFromString() -> URL
    func fileInTempDirectoryPath() -> String
}

protocol Alertable {
    func addAlert()
}

protocol EditableCollection {
    func deleteItem(withIndex index: Int)
}
