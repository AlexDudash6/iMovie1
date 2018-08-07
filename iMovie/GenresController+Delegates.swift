//
//  GenresController+Delegates.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/26/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation


extension GenresController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCell
        let movie = movies[indexPath.row]
        
        if let posterInData = movie.value(forKeyPath: "poster") as? NSData,
            let posterImage = UIImage(data: posterInData as Data) {
            cell.posterImageView.image = posterImage
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        movieTitle.text = movie.value(forKey: "title") as? String
        genreLabel.text = movie.value(forKeyPath: "genre") as? String
        watchingDate.text = movie.value(forKeyPath: "watchingDate") as? String
        movieYear.text = movie.value(forKeyPath: "date") as? String
        
        if let rating = movie.value(forKeyPath: "rating") as? Int,
            let posterInData = movie.value(forKeyPath: "poster") as? NSData,
            let posterImage = UIImage(data: posterInData as Data) {
            posterImageView.image = posterImage
            switch rating {
            case 5 : ratingValue.image = #imageLiteral(resourceName: "5 stars")
            case 4 : ratingValue.image = #imageLiteral(resourceName: "4 stars")
            case 3 : ratingValue.image = #imageLiteral(resourceName: "3 stars")
            case 2 : ratingValue.image = #imageLiteral(resourceName: "2 stars")
            case 1 : ratingValue.image = #imageLiteral(resourceName: "1 star")
            default : ratingValue.image = nil
            }
        }
        
        infoView.center = view.center
        infoView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        view.addSubview(infoView)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.genresMovies.addSubview(self.blurManager.setBlur(withTag: 2828, view: self.genresMovies))
            
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.infoView.transform = .identity
        })
    }
    
}

