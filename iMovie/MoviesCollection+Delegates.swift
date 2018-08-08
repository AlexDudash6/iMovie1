//
//  MovieConroller+Delegates.swift
//  MoviesStorage
//
//  Created by Oleksandr O. Dudash on 8/21/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import CoreData

extension MoviesCollection: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, EditableCollection {
   
    func deleteItem(withIndex index: Int) {
        let movie = movies[index]
        let context = CoreDataManager.sharedInstance.context
        context.delete(movie)
        movies.remove(at: index)
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
        moviesCollection.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCell
        
        cell.index = indexPath
        cell.delegate = self
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.movieTitle.text = movie.value(forKeyPath: "title") as? String
        cell.moviePoster.layer.cornerRadius = 5
        cell.moviePoster.layer.masksToBounds = true
        if let posterInData = movie.value(forKeyPath: "poster") as? NSData,
           let posterImage = UIImage(data: posterInData as Data) {
                cell.moviePoster.image = posterImage
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = movies.remove(at: sourceIndexPath.item)
        movies.insert(temp, at: destinationIndexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 16, 8, 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        movieTitleInfo.text = movie.value(forKey: "title") as? String
        genreLabel.text = movie.value(forKeyPath: "genre") as? String
        watchingDateLabel.text = movie.value(forKeyPath: "watchingDate") as? String
        dateLabel.text = movie.value(forKeyPath: "date") as? String
        
        if let rating = movie.value(forKeyPath: "rating") as? Int,
           let posterInData = movie.value(forKeyPath: "poster") as? NSData,
           let posterImage = UIImage(data: posterInData as Data) {
                moviePosterInfo.image = posterImage
            
            switch rating {
            case 5 : ratingIV.image = #imageLiteral(resourceName: "5 stars")
            case 4 : ratingIV.image = #imageLiteral(resourceName: "4 stars")
            case 3 : ratingIV.image = #imageLiteral(resourceName: "3 stars")
            case 2 : ratingIV.image = #imageLiteral(resourceName: "2 stars")
            case 1 : ratingIV.image = #imageLiteral(resourceName: "1 star")
            default : ratingIV.image = nil
            }
        }
        
            infoView.center = view.center
            infoView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
            
            view.addSubview(infoView)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.moviesCollection.addSubview(self.blurManager.setBlur(withTag: 1000, view: self.moviesCollection))
                self.addButton.isEnabled = false
                if let arrayOfBarButtons = self.navigationItem.rightBarButtonItems {
                    for rightBarButtonItem in arrayOfBarButtons {
                        rightBarButtonItem.isEnabled = false
                    }
                }
                self.navigationItem.leftBarButtonItem?.isEnabled = false
                self.infoView.transform = .identity
            })
        }
}
