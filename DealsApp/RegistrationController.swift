//
//  RegistrationController.swift
//  DealsApp
//
//  Created by Tha_ghost on 10/23/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    var emailField: UITextField?
    var firstnameField: UITextField?
    var lastnameField: UITextField?
    var phoneNumberField: UITextField?
    var passwordField: UITextField?
    var registerButton: UIButton?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.view.backgroundColor = UIColor.greenColor()
        createTextFields()
        createButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTextFields() {
        
        firstnameField = UITextField()
        firstnameField!.placeholder = "Firstname"
        firstnameField!.textAlignment = .Center
        firstnameField!.layer.cornerRadius = 10.0
        firstnameField!.backgroundColor = UIColor.whiteColor()
        firstnameField!.translatesAutoresizingMaskIntoConstraints = false
        
        
        let firstnameHeight = NSLayoutConstraint(item: self.firstnameField!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40)
        
        
        firstnameField!.addConstraints([firstnameHeight])
        self.view.addSubview(firstnameField!)
        
       // let CenterX = NSLayoutConstraint(item: self.firstnameField!, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 20)
        let centerY = NSLayoutConstraint(item: self.firstnameField!, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -175)
        let trailing = NSLayoutConstraint(item: self.view, attribute: .TrailingMargin, relatedBy: .Equal, toItem: self.firstnameField!, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1.0, constant: 40)
        let leading = NSLayoutConstraint(item: self.firstnameField!, attribute: .LeadingMargin, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 40)
        
        self.view.addConstraints([centerY, leading, trailing])
        
        //lastname field
        lastnameField = UITextField()
        lastnameField!.translatesAutoresizingMaskIntoConstraints = false
        lastnameField!.placeholder = "Lastname"
        lastnameField!.textAlignment = .Center
        lastnameField!.backgroundColor = UIColor.whiteColor()
        lastnameField!.layer.cornerRadius = 10.0
        //lastnameField!.layer.borderWidth = 1.0
        
        let lastnameHeight = NSLayoutConstraint(item: self.lastnameField!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40)
        //let lastnameWidth = NSLayoutConstraint(item: self.lastnameField!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 250)
        
        lastnameField!.addConstraints([lastnameHeight])
        self.view.addSubview(lastnameField!)
        
        let lastnameTop = NSLayoutConstraint(item: self.lastnameField!, attribute: .Top, relatedBy: .Equal, toItem: self.firstnameField!, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20)
        let lastnameLeading = NSLayoutConstraint(item: self.lastnameField!, attribute: .LeadingMargin, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 40)
        let lastnameTrailing = NSLayoutConstraint(item: self.view, attribute: .TrailingMargin, relatedBy: .Equal, toItem: self.lastnameField!, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1.0, constant: 40)
        
        self.view.addConstraints([lastnameTop, lastnameLeading, lastnameTrailing])
        
        //email field
        emailField = UITextField()
        emailField!.textAlignment = .Center
        emailField!.placeholder = "Email Address"
        emailField!.translatesAutoresizingMaskIntoConstraints = false
        emailField?.backgroundColor = UIColor.whiteColor()
        emailField!.layer.cornerRadius = 10.0
        //emailField!.layer.borderWidth = 1.0
        
        let emailHeight = NSLayoutConstraint(item: self.emailField!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40)
        
        emailField!.addConstraints([emailHeight])
        
        let emailTop = NSLayoutConstraint(item: self.emailField!, attribute: .Top, relatedBy: .Equal, toItem: self.lastnameField!, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1.0, constant: 20)
        let emailLeading = NSLayoutConstraint(item: self.emailField!, attribute: .LeadingMargin, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 40)
        self.view.addSubview(emailField!)
        let emailTrailing = NSLayoutConstraint(item: self.view, attribute: .TrailingMargin, relatedBy: .Equal, toItem: self.emailField!, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1.0, constant: 40)
        
        self.view.addConstraints([emailTop, emailLeading, emailTrailing])
        
       //create phonenumber field
        phoneNumberField = UITextField()
        phoneNumberField!.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberField!.textAlignment = .Center   
        phoneNumberField?.placeholder = "Phone number"
        phoneNumberField!.layer.cornerRadius = 10.0
        phoneNumberField!.backgroundColor = UIColor.whiteColor()
        
        
        let screensize = UIScreen.mainScreen().bounds
        print("Width: \(screensize.width)")
        
        let fwidth = screensize.width*0.67
        print("Result: \(fwidth)")
        
        let t = screensize.width - fwidth
        
        let phoneHeight = NSLayoutConstraint(item: self.phoneNumberField!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40)
        //et phoneWidth = NSLayoutConstraint(item: self.phoneNumberField!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: fwidth)
        
        phoneNumberField!.addConstraints([phoneHeight])
        self.view.addSubview(phoneNumberField!)
        
        let phoneTop = NSLayoutConstraint(item: self.phoneNumberField!, attribute: .Top, relatedBy: .Equal, toItem: self.emailField!, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20)
        let phoneLeading = NSLayoutConstraint(item: self.phoneNumberField!, attribute: .LeadingMargin, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 40)
        let phoneTrailing = NSLayoutConstraint(item: self.view, attribute: .TrailingMargin, relatedBy: .Equal, toItem: self.phoneNumberField!, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1.0, constant: 40)
        
        self.view.addConstraints([phoneTop, phoneLeading, phoneTrailing])
        
        //create password field
        passwordField = UITextField()
        passwordField?.translatesAutoresizingMaskIntoConstraints = false
        passwordField!.placeholder = "Password"
        passwordField!.textAlignment = .Center
        passwordField!.backgroundColor = UIColor.whiteColor()
        passwordField!.layer.cornerRadius = 10.0
        passwordField!.secureTextEntry = true
        
        let passwordHeight = NSLayoutConstraint(item: self.passwordField!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40)
        
        passwordField!.addConstraints([passwordHeight])
        self.view.addSubview(passwordField!)
        
        let passwordTop = NSLayoutConstraint(item: self.passwordField!, attribute: .Top, relatedBy: .Equal, toItem: self.phoneNumberField!, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20)
        let passwordTrailing = NSLayoutConstraint(item: self.view, attribute: .TrailingMargin, relatedBy: .Equal, toItem: self.passwordField!, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1.0, constant: 40)
        let passwordLeading = NSLayoutConstraint(item: self.passwordField!, attribute: .LeadingMargin, relatedBy: .Equal, toItem: self.view!, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 40)
        
        self.view.addConstraints([passwordTop, passwordLeading, passwordTrailing])
    }
    
    func createButton() {
        
        registerButton = UIButton(type: .System)
        registerButton!.setTitle("SIGN UP", forState: UIControlState.Normal)
        registerButton!.backgroundColor = UIColor.blackColor()
        registerButton!.layer.cornerRadius = 8.0
        let color = UIColor(red:0.00, green:0.45, blue:0.74, alpha:1.0)
        registerButton!.backgroundColor = color
        registerButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton!.translatesAutoresizingMaskIntoConstraints = false
        registerButton!.addTarget(self, action: #selector(signUp), forControlEvents: UIControlEvents.TouchUpInside)
        
        //adding height constraint
        let height = NSLayoutConstraint(item: self.registerButton!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40)
        
        self.registerButton!.addConstraints([height])
        self.view.addSubview(self.registerButton!)
        
        let Top = NSLayoutConstraint(item: self.registerButton!, attribute: .Top, relatedBy: .Equal, toItem: self.passwordField!, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 80)
        let Trailing = NSLayoutConstraint(item: self.view, attribute: .TrailingMargin, relatedBy: .Equal, toItem: self.registerButton!, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1.0, constant: 40)
        let leading =  NSLayoutConstraint(item: self.registerButton!, attribute: .LeadingMargin, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 40)
        
        self.view.addConstraints([Top, Trailing, leading])
        
    }
    
    func signUp(button: UIButton) {
        
        //get all attributes from the field
        let firstname:String = firstnameField!.text!
        let lastname:String = lastnameField!.text!
        let phoneNumber:String = phoneNumberField!.text!
        let password:String = passwordField!.text!
        let email = emailField!.text!
        
        //validating parameters before sigining
        if firstname.isEmpty && lastname.isEmpty && phoneNumber.isEmpty && password.isEmpty && email.isEmpty {
            let alertcontroller = UIAlertController(title: "Error", message: "All Fields cannot be empty!!!", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) {
                (action) -> Void in
                print(action)
            }
            
            alertcontroller.addAction(ok)
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return
        }
        
        if firstname.isEmpty {
            let alertcontroller = UIAlertController(title: "Error", message: "Firstname field cannot be empty", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) {
                (action) -> Void in
                print(action)
            }
            
            alertcontroller.addAction(ok)
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return
        }
        
        if lastname.isEmpty {
            let alertcontroller = UIAlertController(title: "Error", message: "Lastname field cannot be empty", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) {
                (action) -> Void in
                print(action)
            }
            
            alertcontroller.addAction(ok)
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return
        }
        
        
        if phoneNumber.isEmpty {
            let alertcontroller = UIAlertController(title: "Error", message: "Phone number field cannot be empty", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) {
                (action) -> Void in
                print(action)
            }
            
            alertcontroller.addAction(ok)
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return
        }
        
        if password.isEmpty {
            let alertcontroller = UIAlertController(title: "Error", message: "Password field cannot be empty", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) {
                (action) -> Void in
                print(action)
            }
            
            alertcontroller.addAction(ok)
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return
        }
        
        if email.isEmpty {
            let alertcontroller = UIAlertController(title: "Error", message: "Email field cannot be empty", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) {
                (action) -> Void in
                print(action)
            }
            
            alertcontroller.addAction(ok)
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return
        }
        
        
        //check if phonenumber length is exactl
        
        if phoneNumber.characters.count != 10 {
            let alertcontroller = UIAlertController(title: "Error", message: "Invalid phone number", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) {
                (action) -> Void in
                print(action)
            }
            
            alertcontroller.addAction(ok)
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return
        }
        
        
        let parameters = ["email":email, "phone":phoneNumber, "firstname":firstname, "lastname":lastname, "password":password]
        let endPoint:String = "http://smat-server.herokuapp.com/users/create"
        
        let url:NSURL? = NSURL(string: endPoint)
        let session = NSURLSession.sharedSession()

        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        //convert to json
        do{
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
            print(parameters)
        }
        catch{
            print("Error converting params to json")
            return
        }
        print("About to")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            
            print("yeeeep")
            guard let data = data where error == nil else{
                //network error
                print("Error: \(error?.localizedDescription)")
                return
            }
            
            let httpResponse = response as! NSHTTPURLResponse//HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if statusCode == 200 {
                
                do {
                    print("Response: \(response)")
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    let result = json as? [String: AnyObject]
                    print("Result: \(result)")
                    guard let token = result!["token"] else {
                        print("Error not able to get data: \(error?.localizedDescription)")
                        return
                    }
                    print("Token: \(token)")
                    NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
                    let responseString = String(data: data, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.getHome()
                    })
                }
                
                catch {
                    print("Error with information")
                    
                }
            }
            else {
                print("Error: \(statusCode)")
                dispatch_async(dispatch_get_main_queue(), {
                    let alertcontroller = UIAlertController(title: "Error", message: "Unable to process the request", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "Ok", style: .Default) {
                        (action) -> Void in
                        print(action)
                    }
                    alertcontroller.addAction(ok)
                    self.presentViewController(alertcontroller, animated: true, completion: nil)
                    return
                })
            }
            
        })
        
        task.resume()
        //self.getHome()
        firstnameField!.becomeFirstResponder()
        lastnameField!.becomeFirstResponder()
        emailField!.becomeFirstResponder()
        phoneNumberField!.becomeFirstResponder()
        passwordField!.becomeFirstResponder()
    }
    
    func getHome() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableController = storyboard.instantiateViewControllerWithIdentifier("tabController")
        
        let appledDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //appledDelegate.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        appledDelegate.window?.rootViewController = tableController
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
