//
//  MovieModel.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 3/7/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class MovieModel: Mappable {
    
    var title: String?
    var year: String?
    var posterUrl: String?
    
    required init(map: Map) { }
    
    func mapping(map: Map) {
        title <- map["Title"]
        year <- map["Year"]
        posterUrl <- map["Poster"]
    }
}
