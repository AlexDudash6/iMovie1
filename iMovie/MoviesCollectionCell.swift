//
//  MoviesCollectionCell.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 12/22/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit

class MoviesCollectionCell: UITableViewCell {
    
    @IBOutlet private weak var moviesCollection: UICollectionView!
    
    @IBAction func seeAllButtonTapped(_ sender: UIButton) {
        
    }

    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        moviesCollection.delegate = dataSourceDelegate
        moviesCollection.dataSource = dataSourceDelegate
        moviesCollection.tag = row
        moviesCollection.reloadData()
    }
}
