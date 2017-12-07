//
//  AddEditTableViewController.swift
//  MealCollectionDemo
//
//  Created by Kokpheng on 12/5/17.
//  Copyright © 2017 KSHRD. All rights reserved.
//

import UIKit

class AddEditMealTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController() // Create image picker view controller
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var shortDescriptionTextField: UITextField!
    @IBOutlet weak var longDescriptionTextView: UITextView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var meal : Meal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add / Update"
        navigationItem.largeTitleDisplayMode = .never
        
        imagePicker.delegate = self
        
        if meal != nil {
            titleTextField.text = meal.title
            shortDescriptionTextField.text = meal.short_description
            longDescriptionTextView.text = meal.long_description
            thumbnailImageView.image = UIImage(data: meal.image!)
        }
        
        setupThumbnailImageView()
    }
    
    func setupThumbnailImageView() {
        // border radius
        thumbnailImageView.layer.cornerRadius = 5
        thumbnailImageView.layer.masksToBounds = true
        
        // border
        thumbnailImageView.layer.borderColor = UIColor.lightGray.cgColor
        thumbnailImageView.layer.borderWidth = 0.5
        
        
        // border radius
        longDescriptionTextView.layer.cornerRadius = 5
        longDescriptionTextView.layer.masksToBounds = true
        
        // border
        longDescriptionTextView.layer.borderColor = #colorLiteral(red: 0.5676869154, green: 0.7538596988, blue: 0.1165765896, alpha: 1)
        longDescriptionTextView.layer.borderWidth = 1
    }
    
    @IBAction func browseImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        let mealService = MealService()
        
        // Create
        if meal != nil{
            // update
            meal.title = titleTextField.text
            meal.short_description = shortDescriptionTextField.text
            meal.long_description =  longDescriptionTextView.text
            meal.image = UIImageJPEGRepresentation(thumbnailImageView.image!, 0.0)
            mealService.update(updatedPerson: meal)
        }else{
            // create
            _ = mealService.create(title: titleTextField.text!, shortDescription: shortDescriptionTextField.text!, longDescription: longDescriptionTextView.text!, thumbnail: UIImageJPEGRepresentation(thumbnailImageView.image!, 0.0)!)
        }
        mealService.saveChanges()
        self.navigationController?.popViewController(animated: true) // After save go back to home.
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbnailImageView.contentMode = .scaleAspectFit
            thumbnailImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true) // After save go back to home.
    }
}
