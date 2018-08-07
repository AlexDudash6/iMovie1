//
//  GenresController.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/26/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import CoreData

class GenresController: UIViewController {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var genresMovies: UICollectionView!
    @IBOutlet var infoView: UIViewX!
    @IBOutlet weak var posterImageView: UIImageViewX!
    @IBOutlet weak var genreLabel: MAGlowingLabel!
    @IBOutlet weak var ratingValue: UIImageViewX!
    @IBOutlet weak var watchingDate: MAGlowingLabel!
    @IBOutlet weak var movieTitle: MAGlowingLabel!
    @IBOutlet weak var movieYear: MAGlowingLabel!
    
    
    // MARK: - Properties
    
    let userDefaults = UserDefaults.standard
    let blurManager = BlurManager.sharedManager
    var movies: [NSManagedObject] = []
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: userDefaults.imageForKey(key: Constants.UserDefaultKeys.AppBackground.rawValue) ?? #imageLiteral(resourceName: "patternMovie"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        genresMovies.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    
    // MARK: - IBActions

    @IBAction func closeInfoView(_ sender: UIButtonX) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.blurManager.removeBlur(withTag: 2828, view: self.genresMovies)
            self.infoView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: {(success) in
            self.infoView.removeFromSuperview()
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        })
    }
}
