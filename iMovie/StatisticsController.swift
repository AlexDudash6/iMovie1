//
//  StatisticsController.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/25/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import CSPieChart

class StatisticsController: UIViewController {
    
    
    // MARK: - Constants
    
    let userDefaults = UserDefaults.standard
    let kDrama = Constants.Genres.Drama.rawValue
    let kComedy = Constants.Genres.Comedy.rawValue
    let kThriller = Constants.Genres.Thriller.rawValue
    let kHorror = Constants.Genres.Horror.rawValue
    let kWestern = Constants.Genres.Western.rawValue
    let kAction = Constants.Genres.Action.rawValue
    let kDetective = Constants.Genres.Detective.rawValue
    let kAnimation = Constants.Genres.Animation.rawValue
    let kMelodrama = Constants.Genres.Melodrama.rawValue
    let kFantasy = Constants.Genres.Fantasy.rawValue
    let kSeries = Constants.Genres.Series.rawValue
    
    
    // MARK: - Properties
    
    @IBOutlet weak var pieChart: CSPieChart!
    @IBOutlet weak var backgroundIV: UIImageView!
    
    var colorList: [UIColor] = Constants.colorValues as! [UIColor]
    var dataList: [CSPieChartData] = []
    var genre = ""
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartSet()
        view.backgroundColor = UIColor(patternImage: userDefaults.imageForKey(key: Constants.UserDefaultKeys.AppBackground.rawValue) ?? #imageLiteral(resourceName: "patternMovie"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        generateDataList()
    }
    
    
    // MARK: - Helpers
    
    func pieChartSet() {
        pieChart.delegate = self
        pieChart.dataSource = self
        pieChart.seletingAnimationType = .piece
        pieChart.show(animated: true)
    }
    
    
    func countOfElements<T>(_ array: [T]) -> Int {
        return array.count
    }
    
    func generateDataList() {
        let pieChartDataList = [
                CSPieChartData(key: kDrama, value: getCountOfMoviesInGenre(genre: kDrama)),
                CSPieChartData(key: kComedy, value: getCountOfMoviesInGenre(genre: kComedy)),
                CSPieChartData(key: kThriller, value: getCountOfMoviesInGenre(genre: kThriller)),
                CSPieChartData(key: kHorror, value: getCountOfMoviesInGenre(genre: kHorror)),
                CSPieChartData(key: kWestern, value: getCountOfMoviesInGenre(genre: kWestern)),
                CSPieChartData(key: kAction, value: getCountOfMoviesInGenre(genre: kAction)),
                CSPieChartData(key: kDetective, value: getCountOfMoviesInGenre(genre: kDetective)),
                CSPieChartData(key: kAnimation, value: getCountOfMoviesInGenre(genre: kAnimation)),
                CSPieChartData(key: kMelodrama, value: getCountOfMoviesInGenre(genre: kMelodrama)),
                CSPieChartData(key: kFantasy, value: getCountOfMoviesInGenre(genre:kFantasy)),
                CSPieChartData(key: kSeries, value: getCountOfMoviesInGenre(genre: kSeries))
            ]
        dataList = pieChartDataList
    }
    
    func getCountOfMoviesInGenre(genre: String) -> Double {
        let count = self.countOfElements(CoreDataManager.sharedInstance.fetchMoviesWithGenre(genre: genre))
        return Double(count)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGenres" {
            let targetController = segue.destination as! GenresController
            targetController.movies = CoreDataManager.sharedInstance.fetchMoviesWithGenre(genre: genre)
            targetController.navigationItem.title = genre + "'s"
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func reloadPie(_ sender: UIBarButtonItem) {
        pieChart.reloadPieChart()
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
