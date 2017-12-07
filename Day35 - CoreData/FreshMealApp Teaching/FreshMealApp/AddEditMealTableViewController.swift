//
//  AddEditMealTableViewController.swift
//  FreshMealApp
//
//  Created by KSHRD on 12/6/17.
//  Copyright © 2017 Kokpheng. All rights reserved.
//

import UIKit

class AddEditMealTableViewController: UITableViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var shortDescriptionTextField: UITextField!
    @IBOutlet weak var longDescriptionTextView: UITextView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var addEditMealNavigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCornerRadius(view: longDescriptionTextView)
        setupViewCornerRadius(view: thumbnailImageView)
        
        if #available(iOS 11.0, *) {
            addEditMealNavigationBar.largeTitleDisplayMode = .never
        }
    }
    
    func setupViewCornerRadius(view: UIView) {
        
        let layer = view.layer
        // Corner
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        // Border
        layer.borderColor = #colorLiteral(red: 0.5676869154, green: 0.7538596988, blue: 0.1165765896, alpha: 1)
        layer.borderWidth = 1
    }
    
    @IBAction func saveAction(_ sender: Any) {
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}



