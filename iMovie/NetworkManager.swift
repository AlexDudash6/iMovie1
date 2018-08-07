//
//  NetworkManager.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 3/7/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    private init() {}
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, imageView: UIImageView) {
        getDataFromUrl(url: url) { (data, response, error)  in
            DispatchQueue.main.sync() { () -> Void in
                guard let data = data, error == nil else { return }
                imageView.image = UIImage(data: data)
            }
        }
    }

}
