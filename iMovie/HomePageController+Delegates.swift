//
//  HomePageController+Delegates.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 12/22/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit

extension HomePageController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {

    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellIdentifier: String!
        
        switch sections[indexPath.section].items[indexPath.row] {
        case .AllMovies:
            cellIdentifier = "AllMoviesIdentifier"
        case .WatchLater:
            cellIdentifier = "WatchLaterIdentifier"
        case .Favorites:
            cellIdentifier = "FavoritesIdentifier"
        case .Search:
            cellIdentifier = "SearchIdentifier"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section].type {
        case .RelatedMovies:
            return "Related Movies"
        case .Categories:
            return "Categories"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? AllMoviesCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section].type {
        case .RelatedMovies:
            return 195
        case .Categories:
            return 45
        }
    }
    
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 16, 8, 16)
    }
    
}
