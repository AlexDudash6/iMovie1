//
//  WatchLaterController.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 1/3/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import CoreData

class WatchLaterController: UIViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var watchLaterCollection: UICollectionView!
    @IBOutlet weak var infoView: UIViewX!
    @IBOutlet weak var watchLaterPoster: UIImageViewX!
    @IBOutlet weak var movieTitle: MAGlowingLabel!
    @IBOutlet weak var movieYear: MAGlowingLabel!
    @IBOutlet weak var movieGenre: MAGlowingLabel!
    @IBOutlet weak var watchedImageView: UIImageView!
    @IBOutlet weak var movieRating: RatingControl!
    @IBOutlet weak var addToFavorites: BEMCheckBox!

    let userDefaults = UserDefaults.standard
    var movies: [NSManagedObject] = []
    var divisor: CGFloat!
    var indexPathFromCollection: IndexPath!
    let blurManager = BlurManager.sharedManager
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        divisor = (view.frame.width / 2) / 0.61
        
        view.backgroundColor = UIColor(patternImage: userDefaults.imageForKey(key: Constants.UserDefaultKeys.AppBackground.rawValue) ?? #imageLiteral(resourceName: "patternMovie"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        movies = CoreDataManager.sharedInstance.fetchWatchLaterFromCoreData()
        watchLaterCollection.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    
    // MARK: - UI
    
    @IBAction func closeInfoView(_ sender: UIButtonX) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.blurManager.removeBlur(withTag: 1010, view: self.watchLaterCollection)
            self.infoView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: {(success) in
            self.infoView.removeFromSuperview()
        })
    }
    
    func todaysDateToString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func panMovie(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view else { return }
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
        if xFromCenter > 0 {
            watchedImageView.alpha = abs(xFromCenter / view.center.x)
            if watchedImageView.alpha >= 0.8 {
                updateMovie()
                self.blurManager.removeBlur(withTag: 1010, view: watchLaterCollection)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        if sender.state == .ended {
            if card.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                return
            }
            
            UIView.animate(withDuration: 0.2) {
                card.center = self.view.center
                self.watchedImageView.alpha = 0
            }
        }
    }
}
