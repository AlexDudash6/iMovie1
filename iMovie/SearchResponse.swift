//
//  SearchResponse.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 3/7/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class SearchResponse: Mappable {
    
    var searchArray: [MovieModel] = []
    var searchCount: String?
    var isSuccess: String?
    
    required init(map: Map) { }
    
    func mapping(map: Map) {
        searchArray <- map["Search"]
        searchCount <- map["totalResults"]
        isSuccess <- map["Response"]
    }
}
