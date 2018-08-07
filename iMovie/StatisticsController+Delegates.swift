//
//  StatisticsController+Delegates.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 4/25/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import CSPieChart

extension StatisticsController: CSPieChartDataSource, CSPieChartDelegate {
    
    func numberOfComponentData() -> Int {
        return dataList.count
    }
    
    func pieChartComponentData(at index: Int) -> CSPieChartData {
        return dataList[index]
    }
    
    func numberOfComponentColors() -> Int {
        return colorList.count
    }
    
    func pieChartComponentColor(at index: Int) -> UIColor {
        return colorList[index]
    }
    
    func pieChartComponentSubView(at index: Int) -> UIView {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        view.image = UIImage(named: Constants.imagesArray[index])
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        return view
    }
    
    func numberOfLineColors() -> Int {
        return colorList.count
    }
    
    func pieChartLineColor(at index: Int) -> UIColor {
        return colorList[index]
    }
    
    func numberOfComponentSubViews() -> Int {
        return dataList.count
    }
    
    func didSelectedPieChartComponent(at index: Int) {
        self.genre = dataList[index].key
        performSegue(withIdentifier: "goToGenres", sender: self)
    }
}
