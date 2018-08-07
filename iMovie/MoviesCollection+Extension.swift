//
//  MoviesCollection+Extension.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/10/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import CDAlertView

extension MoviesCollection: Shareble, Alertable {
    
    func urlFromString() -> URL {
        let url = URL(fileURLWithPath: fileInTempDirectoryPath())
        return url
    }
    
    func fileInTempDirectoryPath() -> String {
        guard let bundlePath = Bundle.main.path(forResource: "Snapshot", ofType: ".snp"),
              let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return "" }
        
        let fileManager = FileManager.default
        let fullDestinationPath = URL(fileURLWithPath: destinationPath).appendingPathComponent("Snapshot.snp")
        let fullDestinationPathString = fullDestinationPath.path
        
        do {
            try fileManager.copyItem(atPath: bundlePath, toPath: fullDestinationPathString)
        } catch {
            print(error)
        }
        
        return fullDestinationPathString
    }
    
    func addAlert() {
        let alert = CDAlertView(title: "Delete All movies?", message: "", type: .notification)
        let cancelAction = CDAlertViewAction(title: "Cancel") { (action) in
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        alert.add(action: cancelAction)
        let deleteAction = CDAlertViewAction(title: "Delete") { (action) in
            CoreDataManager.sharedInstance.deleteFromCoreData()
            self.movies.removeAll()
            self.moviesCollection.reloadData()
        }
        alert.add(action: deleteAction)
        alert.show()
    }
    
}
