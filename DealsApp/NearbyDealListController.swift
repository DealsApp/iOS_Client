//
//  NearbyDealListController.swift
//  DealsApp
//
//  Created by Chen, David on 9/22/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import Haneke
import CoreLocation

class NearbyDealListController: UITableViewController, CLLocationManagerDelegate {
    
    let myDeals = DealList()
    var dealsArray = []
    var locationManager = CLLocationManager()
//    var lat: String = ""
//    var long: String = ""
    var coord = CLLocationCoordinate2D(latitude: 0, longitude: 0)
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorization from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        }
        self.refreshControl?.addTarget(self, action: #selector(NearbyDealListController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        print("NearbyDealListController refresh locations = \(coord.latitude) \(coord.longitude)")
        dealsArray = myDeals.getNearbyData(coord)!
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        coord = locValue
        print("NearbyDealListController locations = \(locValue.latitude) \(locValue.longitude)")
        dealsArray = myDeals.getNearbyData(locValue)!
        
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Do any additional setup after loading the view, typically from a nib.
//        dealsArray = myDeals.getNearbyData()!
//        
//    }   //end awakeFromNib
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealsArray.count
    }
    //
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NearbyDealCell", forIndexPath: indexPath) as! NearbyDealCell
        if let deal: [String: AnyObject] = dealsArray[indexPath.row] as? [String : AnyObject]{  //Forced Casting of [String: AnyObject]
            //            let url = NSURL(fileURLWithPath: String(deal["showImageStandardSmall"]!))
            let url = NSURL(string: deal["showImageStandardBig"] as! String)
            cell.nearbyUrlImage.hnk_setImageFromURL(url!)
//            cell.nearbyUrlImage.af_setImageWithURL(url!)
            //            let url = String(deal["showImageStandardSmall"]!)
            //            print(url)    //debug
            //            let data = NSData(contentsOfURL: url) //make sure your image in this url does exist, otherwise unwrap in a if let check
            //            cell.urlImage.image = UIImage(data: data!)
            
            cell.nearbyNameLabel.text = String (deal["name"]!)
            //            print (deal["name"]!)   //Removes Optional Binding debug
        }
        //        cell.locationNameLabel.text = vacationSpot.locationName
        //        cell.thumbnailImageView.image = UIImage(named: vacationSpot.thumbnailName)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let selectedCell = sender as? UITableViewCell, selectedRowIndex = tableView.indexPathForCell(selectedCell)?.row
            where segue.identifier == "showNearbyDealDetailController" else {
                fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
        }
        
        let deal = dealsArray[selectedRowIndex]
        
        //        if let deal: [String: AnyObject] = dealsArray[selectedRowIndex] as! [String : AnyObject]{
        //                print(deal["dealTitle"]!)
        let detailViewController = segue.destinationViewController as! NearbyDealDetailController
        detailViewController.deal = deal as! [String: AnyObject]
        //        }
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
