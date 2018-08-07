//
//  AllMoviesCell.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 12/22/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit

class AllMoviesCell: UITableViewCell {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        moviesCollectionView.delegate = dataSourceDelegate
        moviesCollectionView.dataSource = dataSourceDelegate
        moviesCollectionView.tag = row
        moviesCollectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moviesCollectionView.frame = self.contentView.bounds
    }
}
