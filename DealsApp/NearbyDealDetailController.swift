//
//  NearbyDealDetailController.swift
//  DealsApp
//
//  Created by Chen, David on 9/22/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Braintree

class NearbyDealDetailController: UIViewController, BTDropInViewControllerDelegate {
    var braintreeClient: BTAPIClient?
    var deal = [String: AnyObject]()
    var success: Bool = false
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    
    @IBOutlet weak var detailDescription: UILabel!
    
    @IBAction func redeem(sender: UIButton!) {
        let clientTokenURL = NSURL(string: "https://aqueous-taiga-51771.herokuapp.com/V.ZeroPHPServer/server.php")!
        let clientTokenRequest = NSMutableURLRequest(URL: clientTokenURL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
        
        NSURLSession.sharedSession().dataTaskWithRequest(clientTokenRequest) { (data, response, error) -> Void in
            //NSURLSession makes the server call.
            // TODO: Handle errors
            let clientToken = String(data: data!, encoding: NSUTF8StringEncoding)
            
            self.braintreeClient = BTAPIClient(authorization: clientToken!)
            // As an example, you may wish to present our Drop-in UI at this point.
            // Continue to the next section to learn more...
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tappedMyPayButton()
            })
            
            }.resume()
        
        print ("deal_id: \(deal["_id"]!)")
        let dealUrlID = NSURL(string: "http://smat-server.herokuapp.com/deals/redeem/\(deal["_id"]!)")!
        let request = NSMutableURLRequest(URL: dealUrlID)
        //            request.HTTPBody = "\(deal["_id"]!)".dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "GET"
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
            //                    print("Response: \(response)")
            //                    var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //                    print("Body: \(strData)")
            
            }.resume()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = deal["dealTitle"] as? String    //casting whatever comes out of deal["detalTitle"] as a String provided it's not nil.
        
        detailDescription.numberOfLines = 0
        detailDescription.text = deal["dealinfo"] as? String
        priceLabel.text = "Price"
        priceValue.text = deal["dealPrice"]?.stringValue
    }
    
    
    func dropInViewController(viewController: BTDropInViewController,
                              didSucceedWithTokenization paymentMethodNonce: BTPaymentMethodNonce)
    {
        
        var amount = deal["dealPrice"]?.stringValue as? String!
        
        // Send payment method nonce to your server for processing
        print("######Nonce is: \(paymentMethodNonce.nonce)")
        postTransactionToServer(paymentMethodNonce.nonce, amount: amount!)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dropInViewControllerDidCancel(viewController: BTDropInViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postTransactionToServer(paymentMethodNonce: String, amount: String) {
        let paymentURL = NSURL(string: "https://aqueous-taiga-51771.herokuapp.com/V.ZeroPHPServer/server.php")!
        let request = NSMutableURLRequest(URL: paymentURL)
        request.HTTPBody = "payment_method_nonce=\(paymentMethodNonce)&amount=\(amount)".dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
            //                print("Response: \(response)")
            //                var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //                print("Body: \(strData)")
            dispatch_async(dispatch_get_main_queue()) {
                if(error == nil) {
                    let successAlert = UIAlertController(title: "Payment Confirmed", message: "Thank You for Your Purchase!", preferredStyle: .Alert)
                    successAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(successAlert, animated: true, completion: nil)
                    self.success = true
                }
                else {
                    let failAlert = UIAlertController(title: "Payment Failed", message: "Please Try Again!!", preferredStyle: .Alert)
                    failAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(failAlert, animated: true, completion: nil)
                    
                    self.success = false
                }
            }
        }.resume()
    }
    
    func tappedMyPayButton() {
        
        // If you haven't already, create and retain a `BTAPIClient` instance with a
        // tokenization key OR a client token from your server.
        // Typically, you only need to do this once per session.
        //         braintreeClient = BTAPIClient(authorization: clientToken)
        
        // Create a BTDropInViewController
        let dropInViewController = BTDropInViewController(APIClient: braintreeClient!)
        dropInViewController.delegate = self
        
        
        
        dropInViewController.view.tintColor = UIColor(red: 255/255.0, green: 136/255.0, blue: 51/255.0, alpha: 1.0)
        
        let paymentRequest = BTPaymentRequest()
        paymentRequest.showDefaultPaymentMethodNonceFirst = true
        paymentRequest.summaryTitle = deal["dealTitle"] as? String
        paymentRequest.summaryDescription = deal["name"] as? String
        paymentRequest.displayAmount = "$ " + (deal["dealPrice"]!.stringValue as? String)!
        paymentRequest.callToActionText = "Buy Now"
        
        //        sendAmount(deal["dealPrice"]!.stringValue)
        
        dropInViewController.paymentRequest = paymentRequest
        
        // This is where you might want to customize your view controller (see below)
        
        // The way you present your BTDropInViewController instance is up to you.
        // In this example, we wrap it in a new, modally-presented navigation controller:
        dropInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Cancel,
            target: self, action: "userDidCancelPayment")
        let navigationController = UINavigationController(rootViewController: dropInViewController)
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func userDidCancelPayment() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "presentMapViewController":
            guard let navigationController = segue.destinationViewController as? UINavigationController,
                let mapViewController = navigationController.topViewController as? MapViewController else {
                    fatalError("Unexpected view hierarchy")
            }
            
            let lat = deal["lat"] as? Double
            let long = deal["lon"] as? Double
            
            let coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            
            mapViewController.locationToShow = coordinate
            mapViewController.title = deal["name"] as? String
            //        case "presentRatingViewController":
            //            guard let navigationController = segue.destinationViewController as? UINavigationController,
            //                let ratingViewController = navigationController.topViewController as? RatingViewController else {
            //                    fatalError("Unexpected view hierarchy")
            //            }
        //            ratingViewController.vacationSpot = vacationSpot
        default:
            fatalError("Unhandled Segue: \(segue.identifier!)")
        }
    }
}