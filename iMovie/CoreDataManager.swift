//
//  CoredataManager.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 2/7/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: - Get all movies
    
    func fetchValuesFromCoreData() -> [NSManagedObject] {
        
        var movies: [NSManagedObject] = []
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let sort = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            movies = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return movies
    }
    
    
    // MARK: - Fetch Movies with specific Genre
    
    func fetchMoviesWithGenre(genre: String) -> [NSManagedObject] {
        var movies: [NSManagedObject] = []
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let predicate = NSPredicate(format: "genre = %@", genre)
        fetchRequest.predicate = predicate
        
        do {
            movies = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return movies
    }
    
    
    // MARK: - Sort movies with option
    
    func fetchValuesWithSortOption(sortOption: String, ascending: Bool) -> [NSManagedObject] {
        
        var movies: [NSManagedObject] = []
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let sort = NSSortDescriptor(key: sortOption, ascending: ascending)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            movies = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return movies
    }
    
    
    // MARK: - Get favorite movies
    
    func fetchFavoritesFromCoreData() -> [NSManagedObject] {
        
        var favoriteMovies: [NSManagedObject] = []
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let predicate = NSPredicate(format: "isFavorite == TRUE")
        fetchRequest.predicate = predicate
        
        do {
            favoriteMovies = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return favoriteMovies
    }
    
    
    // MARK: - Get watch later movies
    
    func fetchWatchLaterFromCoreData() -> [NSManagedObject] {
        
        var watchLater: [NSManagedObject] = []
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let predicate = NSPredicate(format: "watchLater == TRUE")
        fetchRequest.predicate = predicate
        
        do {
            watchLater = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return watchLater
    }
    
    
    // MARK: - Delete all movies
    
    func deleteFromCoreData() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let result = try? context.fetch(fetchRequest)
        let resultData = result as! [Movie]
        for obj in resultData {
            context.delete(obj)
        }
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save \(error),\(error.userInfo)")
        }
    }
    
    
    // MARK: - Get registered user
    
    func fetchUser() -> [NSManagedObject] {
        
        var users: [NSManagedObject] = []
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            users = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could fetch user. \(error)")
        }
        return users
    }
    
    
    // MARK: - Delete Object From Coredata
    
    func deleteMovie(withTitle title: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let predicate = NSPredicate(format: "title = %@", title)
        fetchRequest.predicate = predicate
        
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    
}

