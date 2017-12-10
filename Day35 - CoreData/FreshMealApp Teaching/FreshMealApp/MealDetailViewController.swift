//
//  MealDetailViewController.swift
//  FreshMealApp
//
//  Created by Ron Rith on 12/10/17.
//  Copyright © 2017 Kokpheng. All rights reserved.
//

import UIKit

class MealDetailViewController: UIViewController {
    @IBOutlet var mealImageView: UIImageView!
    @IBOutlet var mealShortDescLabel: UILabel!
    @IBOutlet var mealLongDescLabel: UILabel!
    @IBOutlet var mealTitleLable: UILabel!
    @IBOutlet var mealCategoryLabel: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet var thumbnailImageHeightConstraint: NSLayoutConstraint!
    
    var mealHolder:Meal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = mealHolder.title
        
        setUpNavigationBar()
        setupContainerView()
        prepareData()

    }
    func setUpNavigationBar(){
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
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
        mealTitleLable.text = mealHolder.title
        mealShortDescLabel.text = mealHolder.short_description
        mealLongDescLabel.text = mealHolder.long_description
        mealImageView.image = UIImage(data: mealHolder.image!)
        if let image = mealImageView.image {
            // Calculate aspect
            let aspect = image.size.height / image.size.width
            thumbnailImageHeightConstraint.constant = view.frame.size.width * aspect
        }
    }

    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if let image = mealImageView.image {
            // Calculate aspect
            let aspect = image.size.height / image.size.width
            
            thumbnailImageHeightConstraint.constant = view.frame.size.width * aspect
        }
    }

    @IBOutlet var Back: UIButton!
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
