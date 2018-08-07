//
//  PDFCreatorController+Extension.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/10/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

extension PDFCreatorController: Shareble {
    
    func urlFromString() -> URL {
        let url = URL(fileURLWithPath: fileInTempDirectoryPath())
        return url
    }
    
    func fileInTempDirectoryPath() -> String {
        guard let bundlePath = Bundle.main.path(forResource: "Favorite Movies", ofType: ".pdf"),
            let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return "" }
        
        let fileManager = FileManager.default
        let fullDestinationPath = URL(fileURLWithPath: destinationPath).appendingPathComponent("Favorite Movies.pdf")
        let fullDestinationPathString = fullDestinationPath.path
        print(fullDestinationPathString)
        
        do {
            try fileManager.copyItem(atPath: bundlePath, toPath: fullDestinationPathString)
        } catch {
            print(error)
        }
        
        return fullDestinationPathString
    }
}
