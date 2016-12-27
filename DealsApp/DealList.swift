//
//  DealList.swift
//  DealsApp
//
//  Created by Chen, David on 9/18/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import Foundation
import CoreLocation

//typealias Payload = [String: [AnyObject]]

public class DealList {
//    public func loadData() -> String {
//        var json: Payload!
//        
//        DataManager.getTopDealsDataFromFileWithSuccess { (data) -> Void in
//            do {
//                json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? Payload
//                //                print("json string is: \(json)")
//            } catch {
//                print(error)
//            }
//            return json
//        }
//    }
    func getNumDeals(coordinate: CLLocationCoordinate2D) -> [String: AnyObject]? {
        var dealCount: String = ""
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getrealtimedealscount/\(coordinate.longitude)/\(coordinate.latitude)")!)
//        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getrealtimedealscount/-121.884851/37.335391")!)
        print("Request is: \(data!)")
        
        do{
            if let JSON: [String: AnyObject] = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? [String: AnyObject] {
//                return JSON
            //print("json is: \(JSON["dealcount"]!)")
            //dealCount = JSON["dealcount"] as! String
            print("this json expression: \(JSON)")
            //return dealCount
            //return JSON["dealcount"] as? String
                return JSON
            }
        } catch {
            print(error)
        }
        
//        if let req: NSData = data {
//            do{
//                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
//                    print("JSON expression is: \(JSON)")
//                    return JSON
//                }
//            } catch let error as NSError {
//                print (error.localizedDescription)
//            }
//        }
        return nil
    }
    
    func getLocalData() -> [[String: AnyObject]]? {
        
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getlocaldeals")!)
        if let req: NSData = data {
            do{
                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                        return JSON
                }
            } catch let error as NSError {
                print (error.localizedDescription)
            }
     
        }
       return nil
      }
   /* func getLocalData(completion:(json:[[String:AnyObject]])->Void) {
        var json:[[String:AnyObject]]?
        let obj = NSUserDefaults.standardUserDefaults().objectForKey("token") as? String
        var token:String?
        
        if let a = obj {
            print("Token: \(a)")
            token = a
        }
        
        let endPoint = "http://smat-server.herokuapp.com/deals/getlocaldeals"
        
        let url:NSURL? = NSURL(string: endPoint)
        let session = NSURLSession.sharedSession()
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue(token!, forHTTPHeaderField: "Authorization-Header")
        
        let task = session.dataTaskWithRequest(request) {(data, response, error) -> Void in
            print("Session")
            guard let data = data where error == nil else {
                //network error
                print("Error with network: \(error?.localizedDescription)")
                return
            }
            
            //print(response)
            let httpResponse = response as! NSHTTPURLResponse//HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if statusCode == 200 {
                do {
                     print("Here buddy")
                     json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [[String: AnyObject]]
                   // return json
                    completion(json:json!)
                }
                
                catch {
                  print("Error in json")
                    completion(json:json!)
                }
            }
        }
        
        task.resume()
        //print("JSON: \(json)")
        
    }*/
    
    func getLocalSFData() -> [[String: AnyObject]]? {
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getlocaldeals/sf")!)
        if let req: NSData = data {
            do{
                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    return JSON
                }
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
        return nil
    }

    func getLocalMVData() -> [[String: AnyObject]]? {
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getlocaldeals/mv")!)
        if let req: NSData = data {
            do{
                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    return JSON
                }
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
        return nil
    }

    
    func getNearbyData(coordinate: CLLocationCoordinate2D) -> [[String: AnyObject]]? {
        
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getrealtimedeals/\(coordinate.longitude)/\(coordinate.latitude)")!)
        if let req: NSData = data {
            do{
                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    return JSON
                }
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
        return nil
    }
    
    func getRestaurantData() -> [[String: AnyObject]]? {
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getdealsbycategory/restaurants")!)
        if let req: NSData = data {
            do{
                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    return JSON
                }
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
        return nil
    }
    func getEntertainmentData() -> [[String: AnyObject]]? {
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getdealsbycategory/entertainment/")!)
        if let req: NSData = data {
            do{
                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    return JSON
                }
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
        return nil
    }
    func getSpaData() -> [[String: AnyObject]]? {
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getdealsbycategory/spa")!)
        if let req: NSData = data {
            do{
                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    return JSON
                }
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
        return nil
    }
    func getServicesData() -> [[String: AnyObject]]? {
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getdealsbycategory/services")!)
        if let req: NSData = data {
            do{
                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    return JSON
                }
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
        return nil
    }
    func getEventsData() -> [[String: AnyObject]]? {
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getdealsbycategory/events")!)
        if let req: NSData = data {
            do{
                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    return JSON
                }
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
        return nil
    }
    func getTravelData() -> [[String: AnyObject]]? {
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getdealsbycategory/travel")!)
        if let req: NSData = data {
            do{
                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    return JSON
                }
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
        return nil
    }
    func getOthersData() -> [[String: AnyObject]]? {
        let data: NSData? = NSData(contentsOfURL: NSURL(string: "http://smat-server.herokuapp.com/deals/getdealsbycategory/others")!)
        if let req: NSData = data {
            do{
                if let JSON: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(req, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    return JSON
                }
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
        return nil
    }

}



//extension DealItem {
//    public class func getTopDealsDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            let filePath = NSBundle.mainBundle().pathForResource("sjdeals", ofType:"json")
//            let data = try! NSData(contentsOfFile:filePath!,
//                options: NSDataReadingOptions.DataReadingUncached)
//            
//            success(data: data)
//        })
//}