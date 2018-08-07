//
//  AddMoviewCOntroller+Delegates.swift
//  MoviesLibrary
//
//  Created by Oleksandr O. Dudash on 8/18/17.
//  Copyright © 2017 Oleksandr O. Dudash. All rights reserved.
//

import UIKit
import FSCalendar

extension AddMovieController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, BEMCheckBoxDelegate, FSCalendarDelegate, UITextFieldDelegate {
    
    func handleTap() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    
    // MARK: - Image Picker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImage : UIImage?
        
        if let editedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = originalImage
        }
        
        if let selectedImageFromPicker = selectedImage {
            moviePosterImageView.image = selectedImageFromPicker
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Date Picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let date = dateFormatter.date(from: years[row])
        let dateString = dateFormatter.string(from: date!)
        movieDate = dateString
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let viewInPicker = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let yearLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        yearLabel.text = years[row]
        yearLabel.textColor = .white
        yearLabel.textAlignment = .center
        yearLabel.font = UIFont(name: "Georgia", size: 20.0)
        viewInPicker.addSubview(yearLabel)
        viewInPicker.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        return viewInPicker
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    
    // MARK: - Calendar
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let string = dateFormatter.string(from: date)
        self.dateOfWatchingTextField.text = string
    }
    
    
    // MARK: - TextField
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateOfWatchingTextField {
            return false
        } else { return true }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == movieTitleTextField) && (textField == movieGenrePickerField) {
        checkAllInputFields()
        }
    }
    
    
}


