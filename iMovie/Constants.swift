//
//  Constants.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/5/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import ChameleonFramework

struct Constants {
    
    
    // MARK: - User Defaults Keys ( Strings )
    
    enum UserDefaultKeys : String {
        case AppColor = "theme"
        case AppColorString = "themeStr"
        case LaunchedBefore = "launchedBefore"
        case SavedPassword = "savedPassword"
        case PlayerStatus = "playerStatus"
        case SoundString = "soundString"
        case SharingEnabled = "sharing"
        case AppBackground = "backgroundImage"
    }
    
    
    // MARK: - Sorting Options
    
    enum SortOptions: String {
        case date, watchingDate, rating
    }
    
    
    // MARK: - Genres
    
    enum Genres: String {
        case Drama, Comedy, Thriller, Horror, Western, Action, Detective, Animation, Melodrama, Fantasy, Series
    }
    
    
    // MARK: - HomePage Table View
    
    enum SectionType {
        case RelatedMovies
        case Categories
    }
    
    enum Cell {
        case AllMovies
        case WatchLater
        case Favorites
        case Search
    }
    
    struct Section {
        var type: SectionType
        var items: [Cell]
    }
    
    
    // MARK: - App Theme Image
    
    static let appBackgroundTheme = "patternMovie"
    
    static let appThemesArray = ["field", "gtr", "lake", "lambo", "mountains", "nightcity", "stars", "sunset"]
    
    static let appImages = [#imageLiteral(resourceName: "gtr"), #imageLiteral(resourceName: "lake"), #imageLiteral(resourceName: "lambo"), #imageLiteral(resourceName: "mountains"), #imageLiteral(resourceName: "nightcity"), #imageLiteral(resourceName: "stars"), #imageLiteral(resourceName: "sunset"), #imageLiteral(resourceName: "spiderman"), #imageLiteral(resourceName: "joker"), #imageLiteral(resourceName: "minion"), #imageLiteral(resourceName: "fish"), #imageLiteral(resourceName: "redsparrow"), #imageLiteral(resourceName: "vendetta"), #imageLiteral(resourceName: "ace"), #imageLiteral(resourceName: "bain"), #imageLiteral(resourceName: "venom"), #imageLiteral(resourceName: "lion"), #imageLiteral(resourceName: "ironman")]
    
    
    // MARK: - Background Sounds
    
    static let musicArray = ["Harry Potter Prologue", "Leon", "Mission Impossible", "Pink Panther", "Rocky3", "Pulp Fiction", "Tokyo Drift", "Black Hole", "Ghostbusters"]
    
    
    // MARK: - App Theme Color
    
    static let colorsDictionary = ["Flat Red": UIColor.flatRed(),
                                    "Flat Orange": UIColor.flatOrange(),
                                    "Flat Black": UIColor.flatBlack(),
                                    "Flat Sky Blue" : UIColor.flatSkyBlue(),
                                    "Flat White" : UIColor.flatWhite(),
                                    "Flat Green" : UIColor.flatGreen(),
                                    "Flat Purple" : UIColor.flatPurple(),
                                    "Flat Lime" : UIColor.flatLime(),
                                    "Flat Yellow" : UIColor.flatYellow(),
                                    "Flat Sand" : UIColor.flatSand(),
                                    "Flat Teal" : UIColor.flatTeal(),
                                    "Flat Watermelon" : UIColor.flatWatermelon(),
                                    "Flat Maroon" : UIColor.flatMaroon(),
                                    "Flat Mint" : UIColor.flatMint(),
                                    "Flat Coffee" : UIColor.flatCoffee()
                                   ]
    
    static let colorStrings = Array(colorsDictionary.keys)
    static let colorValues = Array(colorsDictionary.values)
    
    
    // MARK: - URL+API key IMDB
    
    static let URL = "http://www.omdbapi.com/?apikey=dd52ba61"
    
    
    // MARK: - Movie Genres Constants
    
    static let genres = ["Drama", "Comedy", "Thriller", "Horror", "Western", "Action", "Detective", "Animation", "Melodrama", "Fantasy", "Series"]
    
    
    // MARK: - Properties for Buttons in Circle Menu
    
    static let buttonsForCircleMenu : [(icon: String, color: UIColor)] = [
        ("cancel50", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
        ("search", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
        ("share",  UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
        ]
    
    
    // MARK: - A4 Paper Size
    
    static let a4paperSize = CGSize(width: 595, height: 842)
    
    
    // MARK: - Image Names
    
    static let imagesArray = ["drama", "comedy", "thriller", "horror", "western", "action", "detective", "animation" , "melodrama", "fantasy", "series"]

}
