//
//  CategoryController.swift
//  DealsApp
//
//  Created by Chen, David on 9/28/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import Haneke

class CategoryController: UITableViewController {
//    let myDeals = DealList()
    var dealArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var arrayItem = []
        
//        arrayItem = dealArray[0] as! NSArray
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCell
        if let deal: [String: AnyObject] = dealArray[indexPath.row] as? [String : AnyObject]{  //Forced Casting of [String: AnyObject]
            let url = NSURL(string: deal["showImageStandardBig"] as! String)
            cell.categoryUrlImage.hnk_setImageFromURL(url!)
            cell.categoryNameLabel.text = String (deal["name"]!)
            //            print (deal["name"]!)   //Removes Optional Binding debug
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let selectedCell = sender as? UITableViewCell, selectedRowIndex = tableView.indexPathForCell(selectedCell)?.row
            where segue.identifier == "showCategoryDetailController" else {
                fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
        }
        
        let deal = dealArray[selectedRowIndex]
        
        //        if let deal: [String: AnyObject] = dealsArray[selectedRowIndex] as! [String : AnyObject]{
        //                print(deal["dealTitle"]!)
        let categoryDetailViewController = segue.destinationViewController as! CategoryDetailController
        categoryDetailViewController.deal = deal as! [String: AnyObject]
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}