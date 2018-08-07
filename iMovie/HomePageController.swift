//
//  HomePageController.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 12/27/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import CoreData

class HomePageController: UIViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var configurationTableView: UITableView!
    @IBOutlet weak var allMoviesNumber: UILabel!
    @IBOutlet weak var watchLaterNumber: UILabel!
    @IBOutlet weak var favoritesNumber: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: MAGlowingLabel!
    
    var movies: [NSManagedObject] = []
    var favoriteMovies: [NSManagedObject] = []
    var watchLater: [NSManagedObject] = []
    var users: [NSManagedObject] = []
    
    var sections: [Constants.Section] = []
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurationTableView.reloadData()
        
        fetchAllMovies()
        fillQuantityLabelsWithValues()
        setProfileUI()
    }
    
    
    // MARK: - UI
    
    func fetchAllMovies() {
        movies = CoreDataManager.sharedInstance.fetchValuesFromCoreData()
        watchLater = CoreDataManager.sharedInstance.fetchWatchLaterFromCoreData()
        favoriteMovies = CoreDataManager.sharedInstance.fetchFavoritesFromCoreData()
        users = CoreDataManager.sharedInstance.fetchUser()
    }
    
    func fillQuantityLabelsWithValues() {
        allMoviesNumber.text = String(movies.count)
        watchLaterNumber.text = String(watchLater.count)
        favoritesNumber.text = String(favoriteMovies.count)
    }
    
    func setupUI() {
        configurationTableView.rowHeight = UITableViewAutomaticDimension
        sections = [
            Constants.Section(type: .RelatedMovies, items: [.AllMovies]),
            Constants.Section(type: .Categories, items: [.WatchLater, .Favorites, .Search])
        ]
        
        UIButton.appearanceWhenContained(within: [UITableView.self]).backgroundColor = UIColor.clear
        UIButton.appearanceWhenContained(within: [UIView.self]).backgroundColor = UIColor.clear
        
        userProfileImage.layer.cornerRadius = 75.0
        userProfileImage.layer.borderColor = UIColor.black.cgColor
        userProfileImage.layer.borderWidth = 1
        userProfileImage.clipsToBounds = true
    }
    
    func setProfileUI() {
        let user = users[0]
        guard let username = user.value(forKey: "username") as? String else {
            return
        }
        usernameLabel.text = username
        
        if let photoInData = user.value(forKeyPath: "photo") as? NSData,
           let photo = UIImage(data: photoInData as Data) {
                userProfileImage.image = photo
            }
    }
    
    @IBAction func seeAllMoviesAction(_ sender: UIButton) {
        performSegue(withIdentifier: "seeAll", sender: self)
    }
   
}
