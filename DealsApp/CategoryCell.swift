//
//  CategoryCell.swift
//  DealsApp
//
//  Created by Chen, David on 9/29/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import Foundation
import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var categoryUrlImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryNameLabel.textColor = UIColor.grayColor()
        
        //        // 1
        //        let layoutGuide = UILayoutGuide()
        //        contentView.addLayoutGuide(layoutGuide)
        //
        //        // 2
        //        let topConstraint = layoutGuide.topAnchor
        //            .constraintEqualToAnchor(nameLabel.topAnchor)
        //
        //        // 3
        //        let bottomConstraint = layoutGuide.bottomAnchor
        //            .constraintEqualToAnchor(locationNameLabel.bottomAnchor)
        //
        //        // 4
        //        let centeringConstraint = layoutGuide.centerYAnchor
        //            .constraintEqualToAnchor(contentView.centerYAnchor)
        //
        //        // 5
        //        NSLayoutConstraint.activateConstraints(
        //            [topConstraint, bottomConstraint, centeringConstraint])
    }
}