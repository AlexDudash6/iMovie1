//
//  WatchLaterController+CoreData.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 1/4/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import CoreData

extension WatchLaterController {
    
    func updateMovie() {
        let countOfMovies = movies.count
        if countOfMovies > 0 {
            let movie = movies[indexPathFromCollection.row]
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
            let predicate = NSPredicate(format: "watchLater == TRUE")
            fetchRequest.predicate = predicate
            
            do {
                movies = try managedContext.fetch(fetchRequest)
                if movies.count > 0 {
                    
                    if let watchLater = movie.value(forKey: "watchLater") as? Bool,
                        let isFavorite = movie.value(forKey: "isFavorite") as? Bool,
                        let rating = movie.value(forKey: "rating") as? Int {
                        if watchLater {
                            movie.setValue(false, forKey: "watchLater")
                        }
                        if !isFavorite {
                            movie.setValue(addToFavorites.on, forKey: "isFavorite")
                        }
                        if rating == 0 {
                            movie.setValue(movieRating.rating, forKey: "rating")
                        }
                    }
                    movie.setValue(todaysDateToString(), forKey: "watchingDate")
                }
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            do {
                try managedContext.save()
                appDelegate.saveContext()
            }
            catch let err as NSError {
                print("Could not save. \(err), \(err.userInfo)")
            }
        }
    }
}
