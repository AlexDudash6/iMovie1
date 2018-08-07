//
//  PDFCreatorController.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 3/30/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import Foundation
import SimplePDF
import CoreData
import CircleMenu


class PDFCreatorController : UIViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var menuButton: CircleMenu!
    
    let pdf = SimplePDF(pageSize: Constants.a4paperSize)
    let items = Constants.buttonsForCircleMenu
    let userDefaults = UserDefaults.standard
    
    var docController: UIDocumentInteractionController!
    var urlToSavePDF: URL!
    var pdfData: Data!
    var favoriteMovies: [NSManagedObject] = []
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: userDefaults.imageForKey(key: Constants.UserDefaultKeys.AppBackground.rawValue) ?? #imageLiteral(resourceName: "patternMovie"))
        menuButton.layer.borderColor = UIColor.white.cgColor
        favoriteMovies = CoreDataManager.sharedInstance.fetchFavoritesFromCoreData()
        urlToSavePDF = urlFromString()
        pdfData = createPDF()
        try? pdfData.write(to: urlToSavePDF, options: .atomic)
        docController = UIDocumentInteractionController(url: urlToSavePDF)
        docController.delegate = self
    }
    
    
    // MARK: - Helpers
    
    func createPDF() -> Data {
        var movieTitle, movieYear: String!
        var moviePoster: UIImage!
        var data : Data!
        
        for (index,value) in favoriteMovies.enumerated() {
            print(value)
            let favMovie = favoriteMovies[index]
            pdf.setContentAlignment(.center)
        
            if let title = favMovie.value(forKeyPath: "title") as? String,
                let poster = favMovie.value(forKeyPath: "poster") as? NSData,
                let year = favMovie.value(forKeyPath: "date") as? String,
                let posterImage = UIImage(data: poster as Data) {
                    moviePoster = posterImage
                    movieTitle = title
                    movieYear = year
            }
            
            if index > 0 {
                pdf.beginNewPage()
            }
            pdf.addAttributedText(setAttributesFor(string: movieTitle))
            pdf.addAttributedText(setAttributesFor(string: movieYear))
            pdf.addImage(moviePoster)
        }
        data = pdf.generatePDFdata()
        return data
    }
    
    func setAttributesFor(string: String) -> NSAttributedString {
        var mutableString = NSMutableAttributedString()
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 3
        shadow.shadowOffset = CGSize(width: 3, height: 3)
        shadow.shadowColor = UIColor.gray
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let fontName = UIFont(name: "Chalkduster", size: 30.0)
        
        let attributes: [String : Any] = [NSShadowAttributeName: shadow, NSParagraphStyleAttributeName: paragraph, NSFontAttributeName: fontName ?? "Times New Roman"]
        mutableString = NSMutableAttributedString(string: string, attributes: attributes)
        
        return mutableString
    }
    
    func presentActivityController() {
        let activityController = UIActivityViewController(activityItems: ["", urlToSavePDF], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        UIButton.appearance().tintColor = .black
        
        present(activityController, animated: true, completion: {
            DispatchQueue.main.async {
                UIButton.appearance().tintColor = nil
            }
        })
    }
    
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
