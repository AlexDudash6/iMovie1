//
//  FavoriteMoviesController+Delegates.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 8/25/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit

extension FavoriteMoviesController: iCarouselDataSource,iCarouselDelegate {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return favoriteMovies.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let favoriteMovie = favoriteMovies[index]
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        let imageViewFrame = CGRect(x: 0, y: 0, width: 300, height: 400)
        let blurView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        let titleLabelFrame = CGRect(x: 4, y: 7, width: 190, height: 30)
        
        let imageView = UIImageView()
        let titleLabel = MAGlowingLabel()
        
        imageView.frame = imageViewFrame
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        
        titleLabel.frame = titleLabelFrame
        titleLabel.addGlowingEffect()
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byClipping
        titleLabel.font = UIFont(name: "Georgia", size: 27.0)
        titleLabel.shadowColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.25
        
        if let posterInData = favoriteMovie.value(forKeyPath: "poster") as? NSData,
            let posterImage = UIImage(data: posterInData as Data) {
            imageView.image = posterImage
        }
        
        titleLabel.text = favoriteMovie.value(forKeyPath: "title") as? String
        
        imageView.addSubview(blurView)
        blurView.addSubview(titleLabel)
        tempView.addSubview(imageView)
        
        return tempView
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let favMovie = favoriteMovies[index]
        
        favMovieTitle.text = favMovie.value(forKey: "title") as? String
        genreLabel.text = favMovie.value(forKeyPath: "genre") as? String
        watchingDateLabel.text = favMovie.value(forKeyPath: "watchingDate") as? String
        favMovDate.text = favMovie.value(forKeyPath: "date") as? String
        
        if let rating = favMovie.value(forKeyPath: "rating") as? Int,
            let posterInData = favMovie.value(forKeyPath: "poster") as? NSData,
            let posterImage = UIImage(data: posterInData as Data) {
            favMovPoster.image = posterImage
            switch rating {
            case 5 : favMovRating.image = #imageLiteral(resourceName: "5 stars")
            case 4 : favMovRating.image = #imageLiteral(resourceName: "4 stars")
            case 3 : favMovRating.image = #imageLiteral(resourceName: "3 stars")
            case 2 : favMovRating.image = #imageLiteral(resourceName: "2 stars")
            case 1 : favMovRating.image = #imageLiteral(resourceName: "1 star")
            default : favMovRating.image = nil
            }
        }
        
        favoriteInfoView.center = view.center
        favoriteInfoView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        view.addSubview(favoriteInfoView)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.blurEffectView.alpha = 1
            self.favoriteInfoView.transform = .identity
        })
    }
    
}
