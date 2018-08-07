//
//  SettingsController.swift
//  iMovie
//
//  Created by Oleksandr O. Dudash on 2/14/18.
//  Copyright © 2018 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import Eureka
import ChameleonFramework
import CoreData

class SettingsController: FormViewController {
    
    
    // MARK: - Constants
    
    let userDefaults = UserDefaults.standard
    let colorsDictionary = Constants.colorsDictionary
    let kPlayerStatus = Constants.UserDefaultKeys.PlayerStatus.rawValue
    let kThemeColor = Constants.UserDefaultKeys.AppColor.rawValue
    let kThemeColorString = Constants.UserDefaultKeys.AppColorString.rawValue
    let kSoundString = Constants.UserDefaultKeys.SoundString.rawValue
    let kSharing = Constants.UserDefaultKeys.SharingEnabled.rawValue
    let kAppTheme = Constants.UserDefaultKeys.AppBackground.rawValue
    
    
    // MARK: - Variables
    
    var sharingStatus: String!
    var globalColor: String!
    var newName: String!
    var newPhoto: UIImage!
    var globalSound: String!
    var globalPlaySound: Bool!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sharingStatus = userDefaults.string(forKey: kSharing)
        
        newName = ""
        newPhoto = #imageLiteral(resourceName: "emptyStar")
        
        setUpTableViewWithSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getColorString()
        toggleSound()
    }
    
    
    // MARK: - Helpers
    
    func setUpTableViewWithSettings() {
        let status = userDefaults.string(forKey: kPlayerStatus)
        
        form +++ Section("Edit User Info")
            <<< NameRow() { (nameRow: NameRow) -> Void in
                nameRow.baseCell.backgroundColor = .lightGray
                nameRow.tag = "EditName"
                nameRow.title = "Username"
                nameRow.onChange({ (row) in
                    self.newName = row.value ?? ""
                })
            }
            
            <<< ImageRow() { (imageRow: ImageRow) -> Void in
                imageRow.baseCell.backgroundColor = .lightGray
                imageRow.tag = "EditPhoto"
                imageRow.title = "Photo"
            }
            
            <<< ButtonRow() { (saveButton: ButtonRow) -> Void in
                saveButton.baseCell.backgroundColor = .lightGray
                saveButton.title = "Save Changes"
                saveButton.baseCell.tintColor = .black
                saveButton.baseCell.imageView?.image = #imageLiteral(resourceName: "save50")
                saveButton.baseCell.textLabel?.textAlignment = .left
                
                saveButton.onCellSelection({ (cell, row) in
                    self.updateUser(username: self.newName, photo: self.getUsersNewPhoto())
                    self.dismiss(animated: true, completion: nil)
                })
                
            }
            
            +++ Section("Background Image")
            <<< ButtonRow{ (button : ButtonRow) -> Void in
                button.baseCell.backgroundColor = .lightGray
                button.title = "Pick Image"
                button.baseCell.imageView?.image = #imageLiteral(resourceName: "picture")
                button.baseCell.textLabel?.textAlignment = .left
                button.baseCell.tintColor = .black
                
                button.onCellSelection({ (cell, row) in
                   self.performSegue(withIdentifier: "selectImage", sender: self)
                })

            }
            
            +++ Section("Theme Color")
            <<< PushRow<String>() { (pushRow: PushRow<String>) -> Void in
                pushRow.tag = "ColorRow"
                pushRow.title = "Pick an app theme"
                pushRow.selectorTitle = "Themes"
                pushRow.options = Constants.colorStrings
                pushRow.baseCell.accessoryView?.tintColor = .black
                
                if let themeStr = userDefaults.value(forKey: kThemeColorString) as? String,
                    let color = colorsDictionary[themeStr] {
                        pushRow.value = themeStr
                        pushRow.baseCell.backgroundColor = color
                        
                        if pushRow.value == "Flat Black" {
                            pushRow.baseCell.textLabel?.textColor = .white
                            pushRow.baseCell.accessoryView?.tintColor = .white
                        }
                }
                navigationController?.navigationBar.tintColor = .white
            }
            
            +++ Section("Sharing")
            <<< SwitchRow("Enable Sharing") {
                $0.baseCell.backgroundColor = .lightGray
                $0.title = $0.tag
                $0.value = sharingStatus == "Enabled" ? true : false
                }
                .onChange({ (row) in
                        if row.value == true {
                            self.userDefaults.set("Enabled", forKey: self.kSharing)
                        } else {
                            self.userDefaults.set("Disabled", forKey: self.kSharing)
                        }
            })
            
            +++ Section("Sound")
            <<< SwitchRow("Play background sound") {
                $0.baseCell.backgroundColor = .lightGray
                $0.title = $0.tag
                if status == "OFF" {
                    $0.value = false
                }
                
                }
                .onChange({ (row) in
                    if row.value == true {
                        self.userDefaults.set("ON", forKey: self.kPlayerStatus)
                        self.playMusic()
                    } else {
                        self.userDefaults.set("OFF", forKey: self.kPlayerStatus)
                        self.stopMusic()
                    }
                })
            
            <<< PushRow<String>() { (pushRow: PushRow<String>) -> Void in
                pushRow.baseCell.backgroundColor = .lightGray
                
                pushRow.hidden = .function(["Play background sound"], { form -> Bool in
                    let row: RowOf<Bool>! = form.rowBy(tag: "Play background sound")
                    return row.value ?? false == false
                })
                
                pushRow.tag = "SoundRow"
                pushRow.title = "Pick a background sound"
                pushRow.selectorTitle = "Sounds"
                pushRow.options = Constants.musicArray
                pushRow.baseCell.accessoryView?.tintColor = .black
                
                if let soundString = userDefaults.value(forKey: kSoundString) as? String {
                    pushRow.value = soundString
                }
        }
    }
    
    func toggleSound() {
        let status = userDefaults.string(forKey: kPlayerStatus)
        guard let player = MusicManager.sharedInstance.player else {return}
        if status == "OFF" {
            if (player.isPlaying) {
                player.stop()
            }
        } else {
            playMusic()
        }
    }
    
    func stopMusic() {
        MusicManager.sharedInstance.stopSound()
    }
    
    func playMusic() {
        let row : PushRow<String> = form.rowBy(tag: "SoundRow")!
        
        if let value = row.value {
            globalSound = value
            MusicManager.sharedInstance.playSound(soundName: globalSound)
        } else {
            globalSound = ""
        }
        userDefaults.setValue(globalSound, forKey: kSoundString)
    }
    
    func getColorString() {
        let row : PushRow<String> = form.rowBy(tag: "ColorRow")!
        
        if let value = row.value {
            globalColor = value
            if let color = colorsDictionary[value] {
                row.baseCell.backgroundColor = color
                row.baseCell.textLabel?.backgroundColor = .clear
                row.baseCell.detailTextLabel?.backgroundColor = .clear
            }
            self.setTheme(color: globalColor)
            
        } else { globalColor = "Flat Black"
            row.baseCell.textLabel?.textColor = .white
            row.baseCell.detailTextLabel?.textColor = .white
            self.setTheme(color: globalColor)
        }
        userDefaults.set(globalColor, forKey: kThemeColorString)
    }
    
    func setTheme(color: String) {
        guard let colorValue = colorsDictionary[color] else { return }
        userDefaults.setColor(color: colorValue, forKey: kThemeColor)
        Chameleon.setGlobalThemeUsingPrimaryColor(colorValue, with: .contrast)
    }
    
    func getUsersNewPhoto() -> UIImage {
        let photoRow: ImageRow = form.rowBy(tag: "EditPhoto")!
        
        if let value = photoRow.value {
            newPhoto = value
            return newPhoto
        }
        return #imageLiteral(resourceName: "emptyStar")
    }
    
    func updateUser(username: String, photo: UIImage) {
        
        var users: [NSManagedObject] = []
        
        if let appDelegate =
            UIApplication.shared.delegate as? AppDelegate {

            let managedContext =
                appDelegate.persistentContainer.viewContext
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "User")
            
            do {
                users = try managedContext.fetch(fetchRequest)
                let user = users[0]
                
                if (username == user.value(forKeyPath: "username") as? String) || username.isEmpty {
                    
                    guard let name = user.value(forKeyPath: "username") as? String else { return }
                    self.newName = name
                    
                } else {
                    user.setValue(username, forKey: "username")
                }
                
                var userImageData = UIImageJPEGRepresentation(photo, 1)
                if (userImageData == user.value(forKeyPath: "photo") as? Data) || (self.newPhoto == #imageLiteral(resourceName: "emptyStar")) {
                    userImageData = user.value(forKeyPath: "photo") as? Data
                    user.setValue(userImageData, forKey: "photo")
                } else {
                    let newImageData = UIImageJPEGRepresentation(self.newPhoto, 1)
                    user.setValue(newImageData, forKey: "photo")
                }
                
            } catch let error as NSError {
                print("Could fetch user. \(error)")
            }
            do {
                try managedContext.save()
                appDelegate.saveContext()
            }
            catch let err as NSError {
                print("Could not save. \(err), \(err.userInfo)")
            }
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}




