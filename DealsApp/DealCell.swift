//
//  DealCell.swift
//  DealsApp
//
//  Created by Chen, David on 9/19/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//
// Reused DealCell View for both LocalDeals and NeatbyDeals ViewControllers

import Foundation
import UIKit


class DealCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var urlImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.textColor = UIColor.grayColor()
       
        
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