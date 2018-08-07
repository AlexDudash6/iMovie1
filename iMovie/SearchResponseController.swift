//
//  SearchResponseController.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 3/7/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import CoreData
import DownPicker
import CDAlertView

class SearchResponseController: UIViewController {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchMoviesCollection: UICollectionView!
    @IBOutlet weak var infoView: UIViewX!
    @IBOutlet weak var moviePoster: UIImageViewX!
    @IBOutlet weak var movieTitle: MAGlowingLabel!
    @IBOutlet weak var yearOfRelease: MAGlowingLabel!
    @IBOutlet weak var movieRating: RatingControl!
    @IBOutlet weak var addToFavorites: BEMCheckBox!
    @IBOutlet weak var watchedImageView: UIImageView!
    @IBOutlet weak var watchLaterCheckBox: BEMCheckBox!
    @IBOutlet weak var genrePickerTextField: UITextField!
    
    
    // MARK: - Properties
    
    let userDefaults = UserDefaults.standard
    let genresArray = Constants.genres
    let URL = Constants.URL
    let blurManager = BlurManager.sharedManager
    
    var movies: [MovieModel] = []
    var searchTitle, searchYear: String!
    var indexPathFromCollection: IndexPath!
    var divisor: CGFloat!
    var downPicker: DownPicker!
    var calledBefore = false
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downPicker = DownPicker(textField: genrePickerTextField, withData: genresArray)
        downPicker.addTarget(self, action: #selector(genreValueChanged), for: .valueChanged)
        
        divisor = (view.frame.width / 2) / 0.61
        
        view.backgroundColor = UIColor(patternImage: userDefaults.imageForKey(key: Constants.UserDefaultKeys.AppBackground.rawValue) ?? #imageLiteral(resourceName: "patternMovie"))
        
        self.automaticallyAdjustsScrollViewInsets = false
        getMoviesFromIMDB()
    }
    
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeInfoViewTapped(_ sender: UIButtonX) {
        closeInfoView()
    }
    
    @IBAction func panMovie(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view else { return }
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
        
        if xFromCenter > 0 {
            watchedImageView.alpha = abs(xFromCenter / view.center.x)
            checkAlpha()
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
    
    @IBAction func toggleWatchLater(_ sender: BEMCheckBox) {
        if watchLaterCheckBox.on {
            closeUIElements()
        } else {
            openUIElements()
        }
        self.view.setNeedsLayout()
    }
    
    
    // MARK: - Helpers
    
    func closeUIElements() {
        movieRating.isUserInteractionEnabled = false
        addToFavorites.isUserInteractionEnabled = false
        addToFavorites.on = false
        movieRating.rating = 0
    }
    
    func openUIElements() {
        movieRating.isUserInteractionEnabled = true
        addToFavorites.isUserInteractionEnabled = true
    }
    
    func getGenre() -> String {
        guard let genre = genrePickerTextField.text else {return ""}
        return genre
    }
    
    func todaysDateToString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func chekIfWatchLater() -> Bool {
        let checked = watchLaterCheckBox.on ? true : false
        return checked
    }
    
    func setWatchingDate() -> String {
        if chekIfWatchLater() {
            return ""
        } else { return todaysDateToString() }
    }
    
    func addMovieToDB() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let movie = movies[indexPathFromCollection.row]
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
        
        let movieObj = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        movieObj.setValue(movie.title, forKey: "title")
        movieObj.setValue(movieRating.rating, forKey: "rating")
        movieObj.setValue(getGenre(), forKey: "genre")
        movieObj.setValue(movie.year, forKey: "date")
        movieObj.setValue(addToFavorites.on, forKey: "isFavorite")
        movieObj.setValue(watchLaterCheckBox.on, forKey: "watchLater")
        movieObj.setValue(setWatchingDate(), forKey: "watchingDate")
        
        if let moviePoster = moviePoster.image {
            let moviePosterData = UIImageJPEGRepresentation(moviePoster, 1)
            movieObj.setValue(moviePosterData, forKey: "poster")
        }
        
        do {
            try managedContext.save()
            appDelegate.saveContext()
            calledBefore = true
        } catch let error as NSError {
            print("\(error)")
        }
    }
    
    fileprivate func checkAlpha() {
        if watchedImageView.alpha >= 0.8 {
            if !calledBefore {
                addMovieToDB()
            } else { return }
            self.blurManager.removeBlur(withTag: 1020, view: self.searchMoviesCollection)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func closeInfoView() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.blurManager.removeBlur(withTag: 1020, view: self.searchMoviesCollection)
            self.infoView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: {(success) in
            self.infoView.removeFromSuperview()
        })
    }
    
    func genreValueChanged() {
        guard let genreIsEmpty = genrePickerTextField.text?.isEmpty else { return }
        infoView.isUserInteractionEnabled = genreIsEmpty ? false : true
        self.view.setNeedsLayout()
    }
    
    func getMoviesFromIMDB() {
        guard let title = searchTitle , let year = searchYear else { return }
        Alamofire.request(URL, method: .get, parameters: ["s": title, "y": year]).responseObject { (response: DataResponse<SearchResponse>) in
            switch response.result {
            case .success(let value):
                self.movies = value.searchArray
                self.searchMoviesCollection.reloadData()
            case .failure(_):
                self.addAlert()
            }
        }
    }
    
}
