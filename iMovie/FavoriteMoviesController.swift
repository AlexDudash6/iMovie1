//
//  FavoriteMoviesController.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 8/23/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import CoreData

class FavoriteMoviesController: UIViewController {
    
    
    // MARK: Properties
    
    @IBOutlet var favoriteInfoView: UIViewX!
    @IBOutlet var favMovieTitle: MAGlowingLabel!
    @IBOutlet var favMovPoster: UIImageViewX!
    @IBOutlet var blurEffectView: UIView!
    @IBOutlet var favMovDate: MAGlowingLabel!
    @IBOutlet var favMovRating: UIImageViewX!
    @IBOutlet var genreLabel: MAGlowingLabel!
    @IBOutlet var carousel: iCarousel!
    @IBOutlet weak var watchingDateLabel: MAGlowingLabel!
    @IBOutlet weak var pdfBarButton: UIBarButtonItem!
    @IBOutlet weak var backgroundIV: UIImageView!
    
    let userDefaults = UserDefaults.standard
    var favoriteMovies: [NSManagedObject] = []
    
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }
    
    
    // MARK: - Helpers
    
    fileprivate func setUpUI() {
        view.backgroundColor = UIColor(patternImage: userDefaults.imageForKey(key: Constants.UserDefaultKeys.AppBackground.rawValue) ?? #imageLiteral(resourceName: "patternMovie"))
        
        favoriteMovies = CoreDataManager.sharedInstance.fetchFavoritesFromCoreData()
        carousel.reloadData()
        carousel.type = .coverFlow
        
        pdfBarButton.isEnabled = favoriteMovies.isEmpty ? false : true
    }
    
    
    // MARK: - IBActions

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeFavMovieInfo(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.blurEffectView.alpha = 0
            self.favoriteInfoView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: {(success) in
            self.favoriteInfoView.removeFromSuperview()
        })
    }
    
}
