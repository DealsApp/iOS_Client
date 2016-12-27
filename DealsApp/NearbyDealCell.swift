//
//  NearbyDealCell.swift
//  DealsApp
//
//  Created by Chen, David on 9/22/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import Foundation
import UIKit

class NearbyDealCell: UITableViewCell {

   
    @IBOutlet weak var nearbyNameLabel: UILabel!
  
    
    @IBOutlet weak var nearbyUrlImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        nearbyNameLabel.textColor = UIColor.grayColor()
        
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