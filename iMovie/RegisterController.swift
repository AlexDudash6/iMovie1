//
//  RegisterController.swift
//  MoviewsStorage
//
//  Created by Oleksandr O. Dudash on 12/28/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import CoreData

class RegisterController: UIViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var setPasswordButton: UIButtonX!
    @IBOutlet weak var registerButton: UIButtonX!
    
    let userDefaults = UserDefaults.standard
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkForEmptyFields()
    }
    
    
    // MARK: - UI
    
    func checkForEmptyFields() {
        var password: [Int] = []
        if let passwordFromDefaults = userDefaults.value(forKeyPath: Constants.UserDefaultKeys.SavedPassword.rawValue) as? [Int] {
            password = passwordFromDefaults
        } else { return }
        
        guard let emptyTextField = fullnameTextField.text?.isEmpty else { return }
        
        registerButton.isHidden = (emptyTextField || password.isEmpty || profileImage.image == #imageLiteral(resourceName: "plus")) ? true : false
        
        if !password.isEmpty {
            setPasswordButton.isEnabled = false
        }
    }
    
    func setupUI() {
        registerButton.isHidden = true
        
        fullnameTextField.layer.borderWidth = 1
        fullnameTextField.layer.borderColor = UIColor.white.cgColor
        fullnameTextField.layer.cornerRadius = 15.0
        fullnameTextField.textColor = .black
        
        profileImage.layer.cornerRadius = 75.0
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 1
        profileImage.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        profileImage.addGestureRecognizer(tapGesture)
    }
    
    func saveUser(name: String, photo: UIImage) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        let user = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        user.setValue(name, forKeyPath: "username")
        let userImageData = UIImageJPEGRepresentation(photo, 1)
        user.setValue(userImageData, forKey: "photo")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Couldnt save. \(error)")
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHomePage" {
            if let newName = fullnameTextField.text, let newImage = profileImage.image {
                self.saveUser(name: newName, photo: newImage)
            }
        }
    }
    
}

