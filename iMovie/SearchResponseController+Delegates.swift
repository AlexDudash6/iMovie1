//
//  SearchResponseController+Delegates.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 3/7/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import UIKit

extension SearchResponseController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "SearchMovieCellIdentifier"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SearchCollectionCell
        let movie = movies[indexPath.row]
        
        if let url = NSURL(string: movie.posterUrl!) {
            if let emptyMoviePoster = movie.posterUrl {
                if emptyMoviePoster == "N/A" {
                    cell.contentView.isHidden = true
                    return cell
                }
            }
            cell.moviePoster.contentMode = .scaleAspectFill
            NetworkManager.sharedInstance.downloadImage(url: url as URL, imageView: cell.moviePoster)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        indexPathFromCollection = indexPath
        
        movieTitle.text = movie.title
        yearOfRelease.text = movie.year
        
        if let url = NSURL(string: movie.posterUrl!) {
            NetworkManager.sharedInstance.downloadImage(url: url as URL, imageView: moviePoster)
        }
        
        infoView.center = view.center
        infoView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        
        view.addSubview(infoView)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.searchMoviesCollection.addSubview(self.blurManager.setBlur(withTag: 1020, view: self.searchMoviesCollection))
            self.infoView.transform = .identity
        })
    }
}




