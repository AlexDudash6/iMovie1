//
//  AddMovieController.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 8/21/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import DownPicker
import FSCalendar

class AddMovieController: UIViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet var ratingValue: RatingControl!
    @IBOutlet weak var movieTitleTextField: UITextField!
    @IBOutlet weak var movieGenrePickerField: UITextField!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet var datePicker: UIPickerView!
    @IBOutlet var checkBox: BEMCheckBox!
    @IBOutlet weak var watchLaterCheckBox: BEMCheckBox!
    @IBOutlet weak var dateOfWatchingTextField: UITextField!
    @IBOutlet weak var calendarView: FSCalendar!
    
    let userDefaults = UserDefaults.standard
    let genresArray = Constants.genres
    var years: [String] = []
    var movieTitle, movieGenre, watchingDate, movieDate : String!
    var moviePoster : UIImage!
    var movieRating : Int!
    var rotationAngle : CGFloat!
    var isFavorite , watchLater: Bool!
    var downPicker: DownPicker!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAllInputFields()
    }
    
    
    // MARK: - UI
    
    fileprivate func setUpUI() {
        view.backgroundColor = UIColor(patternImage: userDefaults.imageForKey(key: Constants.UserDefaultKeys.AppBackground.rawValue) ?? #imageLiteral(resourceName: "patternMovie"))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        moviePosterImageView.addGestureRecognizer(tapGestureRecognizer)
        setDataForPicker()
        setUIForPicker()
        downPicker = DownPicker(textField: movieGenrePickerField, withData: genresArray)
        downPicker.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        setImageForTextField()
        calendarView.isHidden = true
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(openCalendar))
        dateOfWatchingTextField.addGestureRecognizer(tapGR)
        
        UIButton.appearanceWhenContained(within: [UIView.self]).backgroundColor = .clear
    }
    
    func valueChanged() {
        checkAllInputFields()
    }
    
    func checkAllInputFields() {
        guard let genreIsEmpty = movieGenrePickerField.text?.isEmpty ,
              let titleIsEmpty = movieTitleTextField.text?.isEmpty else { return }
        saveButton.isEnabled = (genreIsEmpty || titleIsEmpty || moviePosterImageView.image == #imageLiteral(resourceName: "movieDefault")) ? false : true
        self.view.setNeedsLayout()
    }
    
    func openCalendar() {
        calendarView.backgroundColor = .clear
        calendarView.isHidden = false
    }
    
    func openUIElements() {
        calendarView.isHidden = false
        ratingValue.isUserInteractionEnabled = true
        checkBox.isUserInteractionEnabled = true
        dateOfWatchingTextField.isHidden = false
    }
    
    func closeUIElements() {
        calendarView.isHidden = true
        ratingValue.isUserInteractionEnabled = false
        checkBox.isUserInteractionEnabled = false
        dateOfWatchingTextField.isHidden = true
        dateOfWatchingTextField.text = ""
        checkBox.on = false
        ratingValue.rating = 0
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func setImageForTextField() {
        dateOfWatchingTextField.rightViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = #imageLiteral(resourceName: "downArrow.png")
        imageView.image = image
        
        dateOfWatchingTextField.rightView = imageView
    }
    
    func setDataForPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let date = Date()
        let year = Int(formatter.string(from: date))
        guard let currentYear = year else {return}
        for i in 1960...currentYear {
            let str = String(i)
            years.append(str)
        }
    }
    
    func setUIForPicker() {
        datePicker.frame = CGRect(x: 225, y: 115, width: self.view.frame.size.width/5, height: self.view.frame.size.height/3)
        rotationAngle = -90 * (.pi/180)
        datePicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        datePicker.layer.borderWidth = 2
        datePicker.layer.borderColor = UIColor.white.cgColor
        datePicker.backgroundColor = .black
        datePicker.layer.cornerRadius = 5
        datePicker.layer.masksToBounds = true
        datePicker.delegate = self
        datePicker.dataSource = self
        datePicker.selectRow(15, inComponent: 0, animated: false)
    }
    
    @IBAction func toggleCheckBox(_ sender: BEMCheckBox) {
        if watchLaterCheckBox.on {
            closeUIElements()
        } else {
            openUIElements()
        }
        self.view.setNeedsLayout()
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newMovieTitle = movieTitleTextField.text,
            let newMoviePoster = moviePosterImageView.image,
            let newMovieGenre = movieGenrePickerField.text,
            let newMovieDateOfWatching = dateOfWatchingTextField.text {
            
            movieTitle = newMovieTitle
            moviePoster = newMoviePoster
            movieGenre = newMovieGenre
            watchingDate = newMovieDateOfWatching
        }
        
        movieRating = ratingValue.rating
        isFavorite = checkBox.on
        watchLater = watchLaterCheckBox.on
        
    }
}


