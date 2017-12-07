//
//  MealTableViewCell.swift
//  MealCollectionDemo
//
//  Created by KSHRD on 11/23/17.
//  Copyright © 2017 KSHRD. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var thumbnailImageHeightConstrant: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // border radius
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        
        // border
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 1
        
        // drop shadow
        //        containerView.layer.shadowColor = UIColor.black.cgColor
        //        containerView.layer.shadowOpacity = 0.8
        //        containerView.layer.shadowRadius = 3.0
        //        containerView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        //
        //        containerView.clipsToBounds = true
    }

    func configureCell(with meal: Meal) {
        // Set data to control
        titleLabel.text = meal.title
        shortDescriptionLabel.text = "\(meal.short_description ?? "unknown")"
        thumbnailImageView.image = UIImage(data: meal.image!)
        
        if let image = thumbnailImageView.image {
            // Calculate aspect
            let aspect = image.size.height / image.size.width
            
            thumbnailImageHeightConstrant.constant = containerView.frame.size.width * aspect
        }
    }
}
