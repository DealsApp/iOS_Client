//
//  CategoryDealListController.swift
//  DealsApp
//
//  Created by Chen, David on 9/26/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class CategoryDealListController: UITableViewController {
//    let myCategories
    let categoryArray: [String] = ["Restaurants", "Entertainment", "Spa", "Services", "Events", "Travel", "Others"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         print(categoryArray[0])
        return self.categoryArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryDealCell", forIndexPath: indexPath) as! CategoryDealCell
        
//        if let category: [String: AnyObject] = categoryArray[indexPath.row] as? [String : AnyObject]{
            cell.categoryLabel.text = self.categoryArray[indexPath.row]
        
//        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let selectedCell = sender as? UITableViewCell, selectedRowIndex = tableView.indexPathForCell(selectedCell)?.row
            where segue.identifier == "showCategoryController" else {
                fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
        }
        
        let categoryController = segue.destinationViewController as! CategoryController
        let category = categoryArray[selectedRowIndex]
        let myDeals = DealList()
        var dealsArray = []
        //        if let deal: [String: AnyObject] = dealsArray[selectedRowIndex] as! [String : AnyObject]{
        //                print(deal["dealTitle"]!)
        
        switch category {
        case "Restaurants":
            dealsArray = myDeals.getRestaurantData()!
            categoryController.dealArray = dealsArray
        case "Entertainment":
            dealsArray = myDeals.getEntertainmentData()!
            categoryController.dealArray = dealsArray
        case "Spa":
            dealsArray = myDeals.getSpaData()!
            categoryController.dealArray = dealsArray
        case "Services":
            dealsArray = myDeals.getServicesData()!
            categoryController.dealArray = dealsArray
        case "Events":
            dealsArray = myDeals.getEventsData()!
            categoryController.dealArray = dealsArray
        case "Travel":
            dealsArray = myDeals.getTravelData()!
            categoryController.dealArray = dealsArray
        case "Others":
            dealsArray = myDeals.getOthersData()!
            categoryController.dealArray = dealsArray
        default:
            print("Category Not Found")
        }
        
//        let categoryViewController = segue.destinationViewController as! CategoryController
//        categoryViewController.deal = category as! [String: AnyObject]
        //        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
