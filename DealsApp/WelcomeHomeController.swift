//
//  WelcomeHomeController.swift
//  DealsApp
//
//  Created by Tha_ghost on 10/22/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class WelcomeHomeController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
   
    var username:UITextField?
    var passwordField:UITextField?
    var signIn:UIButton?
    var registerButton:UIButton?
    var googleButton:GIDSignInButton?
    var faceButton:FBSDKLoginButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="Welcome"
        let screensize = UIScreen.mainScreen().bounds
        let width = screensize.width;
        let height = screensize.height
        
        let bgView = UIImageView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.image = UIImage(named: "newBckgd.png")
        let w1 = NSLayoutConstraint(item: bgView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: width)
        let h1 = NSLayoutConstraint(item: bgView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: height)
        
        bgView.addConstraints([w1, h1])

        self.view.addSubview(bgView)

        textFields()
        createSignInButton()
        createGoogleButton()
        createFaceBook()
        createRegisterButton()
        
        // Do any additional setup after loading the view.
    }
    
    func textFields() {
        //create Header label and set border
        let screensize = UIScreen.mainScreen().bounds
        let w = screensize.width
        let h = screensize.height
        print("H: \(h)")
        
        let labelHeader:UILabel = UILabel()
        labelHeader.translatesAutoresizingMaskIntoConstraints = false
        labelHeader.text = "DECIBRY"
        labelHeader.textAlignment = .Center
        labelHeader.textColor = UIColor.whiteColor()
        labelHeader.layer.borderColor = UIColor.whiteColor().CGColor
        labelHeader.layer.borderWidth = 3.0
        
        let labelHeight:NSLayoutConstraint = NSLayoutConstraint(item: labelHeader, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 48)
        let labelWidth:NSLayoutConstraint = NSLayoutConstraint(item: labelHeader, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: (w * 0.25))
        
        labelHeader.addConstraints([labelHeight, labelWidth])
        self.view.addSubview(labelHeader)
        
        let labelHeaderCenterX:NSLayoutConstraint = NSLayoutConstraint(item: labelHeader, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let labelHeaderCenterY:NSLayoutConstraint = NSLayoutConstraint(item: labelHeader, attribute: .CenterYWithinMargins, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterYWithinMargins, multiplier: 1.0, constant: -240)
        
        self.view.addConstraints([labelHeaderCenterY, labelHeaderCenterX])
        
        
        //create textfields
        let labelParagraph:UILabel = UILabel()
        labelParagraph.text = "Decibry will expand your reach and allow you to close big deals and tiny deals fast without much effort."
        labelParagraph.lineBreakMode = NSLineBreakMode.ByWordWrapping
        labelParagraph.numberOfLines = 6
        labelParagraph.font = labelParagraph.font.fontWithSize(13)
        labelParagraph.textColor = UIColor.whiteColor()
        labelParagraph.translatesAutoresizingMaskIntoConstraints = false
        labelParagraph.textAlignment = .Center
        
        let labelParagraphHeight = NSLayoutConstraint(item: labelParagraph, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 80)
        //let labelParagaphWidth = NSLayoutConstraint(item: labelParagraph, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: w*0.60)
        
        labelParagraph.addConstraints([ labelParagraphHeight])
        self.view.addSubview(labelParagraph)
        
        let labelParagraphTop = NSLayoutConstraint(item: labelParagraph, attribute: .Top, relatedBy: .Equal, toItem: labelHeader, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20)
        let labelTrail = NSLayoutConstraint(item: self.view, attribute: .Trailing, relatedBy: .Equal, toItem: labelParagraph, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 60)
        let labelLeading = NSLayoutConstraint(item: labelParagraph, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 60)
        
        self.view.addConstraints([labelParagraphTop, labelTrail, labelLeading])
        
        //create username textfield
        username = UITextField()
        username!.autocapitalizationType = UITextAutocapitalizationType.None
        username?.placeholder = "Email"
        username?.textAlignment = .Center
        username?.layer.borderColor = UIColor.grayColor().CGColor
        username?.backgroundColor = UIColor.whiteColor()
        username?.translatesAutoresizingMaskIntoConstraints = false
        //username!.frame = CGRectZero
        username!.layer.borderWidth = 1.0
       
        
       //let Width =  NSLayoutConstraint(item: self.username!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 250)
       let Height =  NSLayoutConstraint(item: self.username!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 45)
        
       //let centerX = NSLayoutConstraint(item: self.username!, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
       let centerY = NSLayoutConstraint(item: self.username!, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -100)
      let left = NSLayoutConstraint(item: self.username!, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 60)
       let trailing = NSLayoutConstraint(item: self.view, attribute: .Trailing, relatedBy: .Equal, toItem: self.username!, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 60)
       // let t = NSLayoutConstraint(item: self.username!, attribute: .TopMargin, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1.0, constant: 20)
        
        username!.addConstraints([ Height])
        
        self.view.addSubview(username!)
        self.view.addConstraints([centerY, trailing, left])
    
        //creates password field
        passwordField = UITextField()
        passwordField?.translatesAutoresizingMaskIntoConstraints = false
        passwordField?.placeholder = "Password"
        passwordField?.textAlignment = .Center
        passwordField?.backgroundColor = UIColor.whiteColor()
        passwordField?.layer.borderColor = UIColor.grayColor().CGColor
        passwordField?.layer.borderWidth = 1.0
        passwordField!.secureTextEntry = true
        self.view.addSubview(passwordField!)
        
        //let psswdFieldWidth = NSLayoutConstraint(item: self.passwordField!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 150)
        let psswdFieldheight = NSLayoutConstraint(item: self.passwordField!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier:1.0, constant: 45)
        
        passwordField?.addConstraints([psswdFieldheight])
        
        //let psswdX = NSLayoutConstraint(item: self.passwordField!, attribute: .CenterX, relatedBy: .Equal, toItem: self.username!, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let psswdTop = NSLayoutConstraint(item: self.passwordField!, attribute: .Top, relatedBy: .Equal, toItem: self.username!, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        let pleft = NSLayoutConstraint(item: self.passwordField!, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 60)
        let ptrailing = NSLayoutConstraint(item: self.view, attribute: .Trailing, relatedBy: .Equal, toItem: self.passwordField!, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 60)
        
       self.view.addConstraints([psswdTop, pleft, ptrailing])
    }
    
    //creates signin button
    func createSignInButton() {
        signIn = UIButton(type: .System)
        signIn?.translatesAutoresizingMaskIntoConstraints = false
        signIn?.setTitle("LOG IN", forState: UIControlState.Normal)
        signIn?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        let color = UIColor(red:0.00, green:0.45, blue:0.74, alpha:1.0)
        signIn?.backgroundColor = color
        signIn?.addTarget(self, action: #selector(buttonAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(signIn!)
        //signIn!.center = self.view.center
        
        //let buttonWidth = NSLayoutConstraint(item: self.signIn!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute:NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 150 )
        let buttonHeight = NSLayoutConstraint(item: self.signIn!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 45)
        
        signIn!.addConstraints([buttonHeight])
        
        let buttonTop = NSLayoutConstraint(item: self.signIn!, attribute: .Top, relatedBy: .Equal, toItem: self.passwordField!, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20)
        let buttonLeading = NSLayoutConstraint(item: self.signIn!, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 60)
        let buttonTrailing = NSLayoutConstraint(item: self.view, attribute: .Trailing, relatedBy: .Equal, toItem: self.signIn!, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 60)
        //let buttonCenterX = NSLayoutConstraint(item: self.signIn!, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        self.view.addConstraints([buttonTop, buttonLeading, buttonTrailing])
        
    }
    
    func buttonAction(button: UIButton!) {
        
        let _username:String = username!.text!
        let _password:String = passwordField!.text!
        
        if( _username.isEmpty && _password.isEmpty) {
            let alertcontroller = UIAlertController(title: "Error", message: "Username and Password field cannot be empty", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) {
                (action) -> Void in
                print(action)
            }
            
            alertcontroller.addAction(ok)
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return
        }
        
        if (_username.isEmpty) {
            let alertcontroller = UIAlertController(title: "Error", message: "Username field cannot be empty", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) {
                (action) -> Void in
                print(action)
            }
            
            alertcontroller.addAction(ok)
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return

        }
        
        if (_password.isEmpty) {
            let alertcontroller = UIAlertController(title: "Error", message: "Password field cannot be empty", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) {
                (action) -> Void in
                print(action)
            }
            
            alertcontroller.addAction(ok)
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return
        }
        
        if !_username.isEmail {
            let alertcontroller = UIAlertController(title: "Error", message: "Username is not a valid email", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default) {
                (action) -> Void in
                print(action)
            }
            
            alertcontroller.addAction(ok)
            self.presentViewController(alertcontroller, animated: true, completion: nil)
            return
        }
        
        
        let params = ["email":_username,"password":_password]
        let endPoints:String = "https://smat-server.herokuapp.com/users/login"
        
        let url:NSURL? = NSURL(string: endPoints)
        let session = NSURLSession.sharedSession()
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
            print(params)
        }
        catch {
            print("Error: \(error)")
        }
        
        print("About to")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            
            print("yeeeep")
            guard let data = data where error == nil  else{
                //network error
                print("Error1234: \(error?.localizedDescription)")
                return
            }
            
            let httpResponse = response as! NSHTTPURLResponse//HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if statusCode == 200 {
                do {
                    print("Imn here")
                    print("Response: \(response)")
                    // let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    let result = json as? [String: AnyObject]
                    print("Result: \(result)")
                    guard let token = result!["token"], let firstname = result!["user"]!["firstname"]! else {
                        print("Error: \(error?.debugDescription)")
                        return
                    }
           
                    NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
                    
                    dispatch_async(dispatch_get_main_queue(), {
                    self.getHome()
                    })
                    
                }
                catch {
                    print("Error receiving data")
                }
            }
            
            else {
                
                dispatch_async(dispatch_get_main_queue(),{
                let alertcontroller = UIAlertController(title: "Error", message: "Invalid username and password entered", preferredStyle: .Alert)
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
        username?.resignFirstResponder()
        passwordField?.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("In facebook")
        fetchFbProfile()
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
    
    }
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        
        if error != nil {
            print("Error received from google: \(error.localizedDescription)")
            return
        }
        
        let userId = user.userID
        
        self.connectToserver(userId);
        
    }
    
    func createGoogleButton() {
        googleButton = GIDSignInButton()
        googleButton?.translatesAutoresizingMaskIntoConstraints = false
        googleButton?.addTarget(self, action: #selector(googleSignIn), forControlEvents: UIControlEvents.TouchUpInside)
        GIDSignIn.sharedInstance().uiDelegate = self
        self.view.addSubview(googleButton!)
        
        
        //let googleButtonWidth = NSLayoutConstraint(item: self.googleButton!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 65)
        let googleButtonHeight = NSLayoutConstraint(item: self.googleButton!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 45)
        
        googleButton?.addConstraints([googleButtonHeight])
        
        
        let googleTop = NSLayoutConstraint(item: self.googleButton!, attribute: .Top, relatedBy: .Equal, toItem: self.signIn!, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20)
        let googleTrailing = NSLayoutConstraint(item: self.googleButton!, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 60)
        
        self.view.addConstraints([googleTop, googleTrailing])
        
    }
    func createFaceBook() {
        
        faceButton = FBSDKLoginButton()
        faceButton?.delegate = self
        faceButton!.translatesAutoresizingMaskIntoConstraints = false
        faceButton!.addTarget(self, action: #selector(signInFB), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(faceButton!)
        
        let fbHeight = NSLayoutConstraint(item: self.faceButton!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 45)
        //        let fbWidth = NSLayoutConstraint(item: self.faceButton!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 160)
        
        faceButton!.addConstraints([fbHeight])
        
        let fbTop = NSLayoutConstraint(item: self.faceButton!, attribute: .Top, relatedBy: .Equal, toItem: self.googleButton!, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        let fbLeading = NSLayoutConstraint(item: self.faceButton!, attribute: .Leading, relatedBy: .Equal, toItem: self.googleButton!, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 20)
        let fbTrailing = NSLayoutConstraint(item: self.view, attribute: .Trailing, relatedBy: .Equal, toItem: self.faceButton!, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 60)
        
        self.view.addConstraints([fbTop, fbLeading, fbTrailing])
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getHome() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableController = storyboard.instantiateViewControllerWithIdentifier("tabController")
        
        let appledDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //appledDelegate.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        appledDelegate.window?.rootViewController = tableController        
    }
    
    func createRegisterButton() {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .Center
        //label.font = label.font.fontWithSize(22)
        label.font = UIFont(name: "CourierNewPS-BoldMT", size: 15)
        label.textColor = UIColor.whiteColor()
        label.text = "Don't have an Account?"
        
        let labelHeight = NSLayoutConstraint(item: label, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40)
        label.addConstraints([labelHeight])
        self.view.addSubview(label)
        
        let labelLeading = NSLayoutConstraint(item: label, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 80)
        let labelTrailing = NSLayoutConstraint(item: self.view, attribute: .Trailing, relatedBy: .Equal, toItem: label, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 80)
        let labelTop = NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: self.faceButton!, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 80)
        
        self.view.addConstraints([labelLeading, labelTrailing, labelTop])
        
        registerButton = UIButton(type: .System)
        registerButton!.setTitle("Create Account Now", forState: UIControlState.Normal)
        //registerButton!.titleLabel!.font = UIFont(name: "Arial-MT", size: 15)
        //registerButton!.backgroundColor = UIColor.blueColor()
        registerButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        let color = UIColor(red:0.00, green:0.45, blue:0.74, alpha:1.0)
        registerButton!.backgroundColor = color
        //registerButton!.layer.borderColor = color.CGColor
        //registerButton!.layer.borderWidth = 3.0
        registerButton!.titleLabel?.font = UIFont(name: "CourierNewPS-BoldMT", size: 17)
        registerButton!.translatesAutoresizingMaskIntoConstraints = false
        registerButton!.addTarget(self, action: #selector(registerAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        let width = NSLayoutConstraint(item: self.registerButton!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40)
        
        registerButton!.addConstraints([width])
        
        self.view.addSubview(self.registerButton!)
        
        let top = NSLayoutConstraint(item: self.registerButton!, attribute: .Top, relatedBy: .Equal, toItem: label,
                                     attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 20)
        let trailing = NSLayoutConstraint(item: self.view, attribute: .Trailing, relatedBy: .Equal, toItem: self.registerButton!,
                                          attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 80)
        let leading = NSLayoutConstraint(item: self.registerButton!, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 80)
        
        self.view.addConstraints([top, trailing, leading])
        
    }
    
    func registerAction(button: UIButton) {
        let registration:UIViewController = RegistrationController();
        registration.view.backgroundColor = UIColor.whiteColor()
        let color = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        registration.title = "Registration"
        registration.view.backgroundColor = color
        self.navigationController?.pushViewController(registration, animated: false)
    }
    
    func signInFB() {
        faceButton!.readPermissions = ["email", "public_profile"]
        fetchFbProfile()
    }
    
    private func fetchFbProfile() {
        let parameters = ["fields":"id, email, first_name, last_name"]
        let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: parameters, HTTPMethod: "GET")
        graphRequest.startWithCompletionHandler({(connection, result, error) -> Void in
        
            if error != nil {
                print("Facebook Error: \(error.localizedDescription)")
                return
            }
            
            guard let id = result["id"] as? String else{
                print("Error: \(error.localizedDescription)")
                return
            }
            
            print("FacebookId connecting: \(id)")
            //connect to app server
            //let endspoint: String = "https://smat-server.herokuapp.com/users/loginsocial"
            
            //dispatch_async(dispatch_get_main_queue(), {
            self.connectToserver(id)
            //})
        })
        
    }
    
    func googleSignIn(button: UIButton!) {
        
        //Google
        var error:NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        assert(error == nil, "Error configuring google services \(error)")
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = "714320555608-brin7f4hgjjp5pmtqu3ivk1k4jbed48c.apps.googleusercontent.com"
        
    }
    
     public func connectToserver(id: String) {
        let endPoint: String = "https://smat-server.herokuapp.com/users/loginsocial"
        let params = ["id": id]
        
        let url:NSURL? = NSURL(string: endPoint)
        let session = NSURLSession.sharedSession()
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
            print(params)
        }
        catch {
            print("Error: \(error)")
        }
        
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data where error == nil else {
                print("Error connecting: \(error?.localizedDescription)")
                return
            }
            let httpResponse = response as! NSHTTPURLResponse//HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if statusCode == 200 {
                do {
                    print("Response: \(response)")
                    // let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    let result = json as? [String: AnyObject]
                    print("Result: \(result)")
                    guard let token = result!["token"] else {
                        print("Error: \(error?.debugDescription)")
                        return
                    }
                    
                    NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.getHome()
                    })
                    
                }
                catch {
                    print("Error receiving data")
                }
            }
                
            else {
                
                dispatch_async(dispatch_get_main_queue(),{
                    let alertcontroller = UIAlertController(title: "Error", message: "Invalid username and password entered", preferredStyle: .Alert)
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
