//
//  CategoryDetailController.swift
//  DealsApp
//
//  Created by Chen, David on 9/29/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import Foundation
import MapKit

class CategoryDetailController: UIViewController {
    var deal = [String: AnyObject]()
    @IBOutlet weak var detailDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = deal["dealTitle"] as? String    //casting whatever comes out of deal["detalTitle"] as a String provided it's not nil.
        
        detailDescription.numberOfLines = 0
        detailDescription.text = deal["dealinfo"] as? String
    }
}
