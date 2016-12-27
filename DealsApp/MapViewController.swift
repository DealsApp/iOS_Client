//
//  MapViewController.swift
//  DealsApp
//
//  Created by Chen, David on 9/21/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var locationToShow: CLLocationCoordinate2D!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.setCenterCoordinate(locationToShow, animated: true)
        
        let zoomRegion = MKCoordinateRegionMakeWithDistance(locationToShow, 15000, 15000)
        mapView.setRegion(zoomRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationToShow
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
