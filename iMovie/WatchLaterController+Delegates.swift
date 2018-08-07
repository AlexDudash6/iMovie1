//
//  WatchLaterController+Delegates.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 1/4/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import UIKit

extension WatchLaterController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchLaterCell", for: indexPath) as! WatchLater
        
        let movie = movies[indexPath.row]
        
        if let posterInData = movie.value(forKeyPath: "poster") as? NSData,
            let posterImage = UIImage(data: posterInData as Data) {
            cell.poster.image = posterImage
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        indexPathFromCollection = indexPath
        
        movieTitle.text = movie.value(forKey: "title") as? String
        movieGenre.text = movie.value(forKeyPath: "genre") as? String
        movieYear.text = movie.value(forKeyPath: "date") as? String
        
        if let posterInData = movie.value(forKeyPath: "poster") as? NSData,
            let posterImage = UIImage(data: posterInData as Data) {
            watchLaterPoster.image = posterImage
        }
        infoView.center = view.center
        infoView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        
        view.addSubview(infoView)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.watchLaterCollection.addSubview(self.blurManager.setBlur(withTag: 1010, view: self.watchLaterCollection))
            self.infoView.transform = .identity
        })
    }
}
