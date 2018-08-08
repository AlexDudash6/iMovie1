//
//  ViewController.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 8/21/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import CoreData
import CDAlertView

class MoviesCollection: UIViewController {
    
    
    // MARK: - InfoView Properties
    
    @IBOutlet var ratingIV: UIImageViewX!
    @IBOutlet weak var moviePosterInfo: UIImageView!
    @IBOutlet weak var movieTitleInfo: MAGlowingLabel!
    @IBOutlet var infoView: UIViewX!
    @IBOutlet var genreLabel: MAGlowingLabel!
    @IBOutlet var dateLabel: MAGlowingLabel!
    @IBOutlet weak var watchingDateLabel: MAGlowingLabel!
    @IBOutlet weak var shareButton: UIButton!
    
    
    // MARK: - MoviesCollection Properties
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    @IBOutlet var addButton: RoundedButton!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    let cellIdentifier = "movieCell"
    let userDefaults = UserDefaults.standard
    var movies: [NSManagedObject] = []
    var isSelected: Bool!
    var sortingOption = Constants.SortOptions.date.rawValue
    var barButtonItems: [UIBarButtonItem] = []
    var panGestureForAddButton = UIPanGestureRecognizer()
    var urlToSaveSnap: URL!
    let blurManager = BlurManager.sharedManager
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        urlToSaveSnap = urlFromString()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movies = CoreDataManager.sharedInstance.fetchValuesFromCoreData()
        toggleBarButtonItems()
    }
    
    
    // MARK: - Helpers
    
    fileprivate func toggleBarButtonItems() {
        for barButton in barButtonItems {
            barButton.isEnabled = movies.count > 0 ? true : false
        }
    }
    
    fileprivate func setUpUI() {
        let sharingStatus = userDefaults.string(forKey: Constants.UserDefaultKeys.SharingEnabled.rawValue)
        shareButton.isHidden = sharingStatus == "Enabled" ? false : true
        
        moviesCollection.allowsMultipleSelection = true
        view.backgroundColor = UIColor(patternImage: userDefaults.imageForKey(key: Constants.UserDefaultKeys.AppBackground.rawValue) ?? #imageLiteral(resourceName: "patternMovie"))
    
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        moviesCollection.addGestureRecognizer(longPressGesture)
        barButtonItems = [trashButton]
        self.navigationItem.rightBarButtonItems = barButtonItems
        
        panGestureForAddButton = UIPanGestureRecognizer(target: self, action: #selector(draggedAddButton(_:)))
        addButton.addGestureRecognizer(panGestureForAddButton)
    }
    
    func draggedAddButton(_ sender: UIPanGestureRecognizer) {
        self.moviesCollection.bringSubview(toFront: addButton)
        let translation = sender.translation(in: self.moviesCollection)
        addButton.center = CGPoint(x: addButton.center.x + translation.x, y: addButton.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.moviesCollection)
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        guard let selectedIndexPath = moviesCollection.indexPathForItem(at: gesture.location(in: moviesCollection)) else {return}
        switch gesture.state {
        case .began:
            moviesCollection.visibleCells.forEach { cell in
                cell.shake()
            }
            moviesCollection.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            moviesCollection.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            moviesCollection.visibleCells.forEach { cell in
                cell.stopWiggle()
            }
            moviesCollection.endInteractiveMovement()
        default:
            moviesCollection.visibleCells.forEach { cell in
                cell.stopWiggle()
            }
            moviesCollection.cancelInteractiveMovement()
        }
    }

    func presentActivityController() {
        guard let image = infoView.takeSnapshot(infoView),
              let data = UIImagePNGRepresentation(image) else { return }
        try? data.write(to: urlToSaveSnap, options: .atomic)
        
        let activityController = UIActivityViewController(activityItems: ["", data], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        UIButton.appearance().tintColor = .black

        present(activityController, animated: true, completion: {
            DispatchQueue.main.async {
                UIButton.appearance().tintColor = nil
            }
        })
    }
    
    
    // MARK: - IBActions
  
    @IBAction func deleteItemsFromDb(_ sender: UIBarButtonItem) {
        addAlert()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @IBAction func closeInfoView(_ sender: UIButtonX) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.blurManager.removeBlur(withTag: 1000, view: self.moviesCollection)
            self.addButton.isEnabled = true
            self.infoView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: {(success) in
            self.infoView.removeFromSuperview()
            for rightBarButtonItem in self.barButtonItems {
                    rightBarButtonItem.isEnabled = true
                }
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        })
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        presentActivityController()
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

