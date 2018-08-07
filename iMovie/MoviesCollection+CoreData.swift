//
//  MoviesColletion+CoreData.swift
//  MoviesStorage
//
//  Created by Oleksandr O. Dudash on 8/21/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import CoreData

extension MoviesCollection {
    
    @IBAction func unwindFromAddMoviewController(_ segue: UIStoryboardSegue) {
        if segue.source is AddMovieController {
            if let senderController = segue.source as? AddMovieController {
                
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
                let managedContext = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
                
                let movie = NSManagedObject(entity: entity!, insertInto: managedContext)
                movie.setValue(senderController.movieTitle, forKey: "title")
                movie.setValue(senderController.movieGenre, forKey: "genre")
                movie.setValue(senderController.movieRating, forKey: "rating")
                movie.setValue(senderController.movieDate, forKey: "date")
                movie.setValue(senderController.isFavorite, forKey: "isFavorite")
                movie.setValue(senderController.watchLater, forKey: "watchLater")
                movie.setValue(senderController.watchingDate, forKey: "watchingDate")
                
                if let moviePoster = senderController.moviePoster {
                    let moviePosterData = UIImageJPEGRepresentation(moviePoster, 1)
                    movie.setValue(moviePosterData, forKey: "poster")
                }
                
                do {
                    try managedContext.save()
                    movies.append(movie)
                } catch let error as NSError {
                    print("\(error)")
                }
                self.moviesCollection.reloadData()
            }
        }
    }
}

