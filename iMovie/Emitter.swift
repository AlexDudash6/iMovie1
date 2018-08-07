//
//  Emitter.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/11/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation

class Emitter {
    static func get(with image: UIImage) -> CAEmitterLayer {
        let emitter = CAEmitterLayer()
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterCells = generateEmitterCells(with: image)
        
        return emitter
    }
    
    static func generateEmitterCells(with image: UIImage) -> [CAEmitterCell] {
        var cells: [CAEmitterCell] = []
        
        let cell = CAEmitterCell()
        cell.contents = image.cgImage
        cell.birthRate = 1
        cell.lifetime = 50
        cell.velocity = CGFloat(25)
        cell.emissionLongitude = (180 * (.pi/180))
        cell.emissionRange = (45 * (.pi/180))
        
        cell.scale = 0.4
        cell.scaleRange = 0.3
        
        cells.append(cell)
        return cells
    }
}
