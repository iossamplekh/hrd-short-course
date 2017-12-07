//
//  MealDetailViewController.swift
//  MealCollectionDemo
//
//  Created by KSHRD on 11/28/17.
//  Copyright © 2017 KSHRD. All rights reserved.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    // Outlet
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    
    @IBOutlet weak var thumbnailImageHeightConstraint: NSLayoutConstraint!
    
    // Data holder
    var mealHolder: Meal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = mealHolder.title
        navigationItem.largeTitleDisplayMode = .never
        
        setupContainerView()
        prepareData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if let image = thumbnailImageView.image {
            // Calculate aspect
            let aspect = image.size.height / image.size.width
            
            thumbnailImageHeightConstraint.constant = view.frame.size.width * aspect
        }
    }
    
    func setupContainerView() {
        // border radius
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        
        // border
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.5
    }
    
    func prepareData() {
        titleLabel.text = mealHolder.title
        shortDescriptionLabel.text = mealHolder.short_description
        longDescriptionLabel.text = mealHolder.long_description
        thumbnailImageView.image = UIImage(data: mealHolder.image!)
        if let image = thumbnailImageView.image {
            // Calculate aspect
            let aspect = image.size.height / image.size.width
            thumbnailImageHeightConstraint.constant = view.frame.size.width * aspect
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
