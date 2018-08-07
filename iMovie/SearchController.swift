//
//  SearchController.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 3/6/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import Eureka

class SearchController: FormViewController {
    
    // MARK: - Properties
    
    let userDefaults = UserDefaults.standard
    var searchName: String!
    var searchYear: String!
    var foundMovies: [MovieModel] = []
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: userDefaults.imageForKey(key: Constants.UserDefaultKeys.AppBackground.rawValue) ?? #imageLiteral(resourceName: "patternMovie"))
        
        searchName = ""
        searchYear = ""
        
    
        setUpTableView()
    }
    
    
    // MARK: - Helpers
    
    fileprivate func setUpTableView() {
        form +++ Section("You want to search by:")
    
            <<< SegmentedRow<String>("segments_tag") {
                $0.baseCell.backgroundColor = .lightGray
                $0.options = ["Title", "Year"]
                $0.value = "Title"
            }
            
            +++ Section() {
                $0.tag = "Title_tag"
            }
            <<< TextRow() {
                $0.baseCell.backgroundColor = .lightGray
                $0.placeholder = "Type title to search for..."
                $0.onChange({ (row) in
                    self.searchName = row.value ?? ""
                })
            }
            
            <<< TextRow() {
                $0.baseCell.backgroundColor = .lightGray
                $0.placeholder = "Type year of your film release..."
                $0.hidden = "$segments_tag != 'Year'"
                $0.onChange({ (row) in
                    self.searchYear = row.value ?? ""
                })
            }
            
            <<< ButtonRow() { (searhRow: ButtonRow) -> Void in
                searhRow.baseCell.backgroundColor = .lightGray
                searhRow.title = "Search"
                searhRow.baseCell.tintColor = .black
                searhRow.baseCell.imageView?.image = #imageLiteral(resourceName: "search")
                searhRow.onCellSelection({ (cell, row) in
                    self.performSegue(withIdentifier: "ShowSearchResults", sender: Any?.self)
                })
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearchResults" {
            
            let targetController = segue.destination as! SearchResponseController
            targetController.searchTitle = searchName
            targetController.searchYear = searchYear
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
