//
//  DealListController.swift
//  DealsApp
//
//  Created by Chen, David on 9/19/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import Haneke


class DealListController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let myDeals = DealList()
    var dealsArray = []
    var cityTitle: String = ""
    
    var city = ["San Jose", "San Francisco", "Mountain View"]
    
    @IBOutlet weak var citiesPicker: UIPickerView!
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBAction func changeCity(sender: UIBarButtonItem) {
        let popOver = UIPopoverController()
//        popOver.contentViewController.view.addSubview(citiesPicker)
//        popOver.presentPopoverFromBarButtonItem(sender, permittedArrowDirections: Any, animated: true)
//        let tableViewController = UITableViewController()
//        tableViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
//        tableViewController.preferredContentSize = CGSizeMake(100, 100)
//        
//        presentViewController(tableViewController, animated: true, completion: nil)
//        
//        let popoverPresentationController = tableViewController.popoverPresentationController
//        popoverPresentationController?.barButtonItem = sender
//        popoverPresentationController?.popoverLayoutMargins = UIEdgeInsetsMake(1, 1, 1, 1)
//        popoverPresentationController?.sourceRect = CGRectMake(0, 0, sender.frame.size.width, sender)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return city.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return city[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.navigationItem.title = self.city[row]
//        self.citiesPicker.hidden = true
        self.tableView.reloadData()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.navigationItem.title {
            self.citiesPicker.hidden = false
            //if you dont want the users to see the keyboard type:
            textField.endEditing(true)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "\(cityTitle)"
//        let deals: [[String: AnyObject]] = myDeals.getData()!

          dealsArray = myDeals.getLocalData()!

        
   
        
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            self.tableView.reloadData()
//        })
//
//        if let dealsArray: [[String: AnyObject]] = myDeals.getData() {
//            for deal in dealsArray {
//                print(deal["name"]!)
//            }
        
        /*myDeals.getLocalData { json in
            print("json: \(json)")
            self.dealsArray = json
            print("h: \(self.dealsArray.count)")
        
        }*/
        //print("h: \(self.dealsArray.count)")
//        }
    }   //end awakeFromNib
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        definesPresentationContext = true
//        tableView.tableHeaderView = searchController.searchBar
//    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.navigationItem.title == "San Francisco") {
            dealsArray = myDeals.getLocalSFData()!
        }
        else if(self.navigationItem.title == "Mountain View") {
            dealsArray = myDeals.getLocalMVData()!
        }
        else {
            dealsArray = myDeals.getLocalData()!
        }
        return dealsArray.count
    }
//
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DealCell", forIndexPath: indexPath) as! DealCell
        if let deal: [String: AnyObject] = dealsArray[indexPath.row] as? [String : AnyObject]{  //Forced Casting of [String: AnyObject]
//            let url = NSURL(fileURLWithPath: String(deal["showImageStandardSmall"]!))
            let url = NSURL(string: deal["showImageStandardBig"] as! String)
            cell.urlImage.hnk_setImageFromURL(url!)
//            cell.urlImage.af_setImageWithURL(url!)
//            let url = String(deal["showImageStandardSmall"]!)
//            print(url)    //debug
//            let data = NSData(contentsOfURL: url) //make sure your image in this url does exist, otherwise unwrap in a if let check
//            cell.urlImage.image = UIImage(data: data!)
            
            cell.nameLabel.text = String (deal["name"]!)
//            print (deal["name"]!)   //Removes Optional Binding debug
        }
//        cell.locationNameLabel.text = vacationSpot.locationName
//        cell.thumbnailImageView.image = UIImage(named: vacationSpot.thumbnailName)
        
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let selectedCell = sender as? UITableViewCell, selectedRowIndex = tableView.indexPathForCell(selectedCell)?.row
            where segue.identifier == "showDealDetailController" else {
                fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
        }
    
        let deal = dealsArray[selectedRowIndex]
        
//        if let deal: [String: AnyObject] = dealsArray[selectedRowIndex] as! [String : AnyObject]{
//                print(deal["dealTitle"]!)
            var detailViewController = DealDetailController()
            detailViewController = segue.destinationViewController as! DealDetailController
            detailViewController.deal = deal as! [String: AnyObject]
//        }
    }
    
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
