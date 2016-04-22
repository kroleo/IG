//
//  LogInView.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit
import Security

class LogInView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var invalidLoginLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    let MyKeyChainWrapper = KeychainWrapper()
    var user: User?
    
    
//    @IBAction func dimisssKeyboard(sender: UITapGestureRecognizer) {
//        dismissKeyboard()
//    }
//    
//    // DISMISS KEYBOARD
//    func dismissKeyboard() {
//        self.passwordField.resignFirstResponder()
//        usernameField.resignFirstResponder()
//    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //dismissKeyboard()
        self.view.endEditing(true)
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameField.autocorrectionType = UITextAutocorrectionType.No
        self.passwordField.autocorrectionType = UITextAutocorrectionType.No
        usernameField.delegate = self
        passwordField.delegate = self
        passwordField.secureTextEntry = true
 
        self.invalidLoginLabel.text = ""
        if NSUserDefaults.standardUserDefaults().boolForKey("signedIn"){
            self.usernameField.text = NSUserDefaults.standardUserDefaults().objectForKey("username") as? String
            print("User found")
            self.passwordField.text = MyKeyChainWrapper.myObjectForKey(kSecValueData) as? String
            loginAction(self)
        }
 
        else{
            print("user not found")
        }
 
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if segue.identifier=="toFrontPostcard" {
            let destination = segue.destinationViewController as? frontPostcard
            destination!.user = self.user
            
        }
    }

    //Validate Email/Username
    
    func isValidEmail(testStr:String) -> Bool {
        
        print("Validate emilId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(testStr)
        
        return result
        
    }
    
    
    @IBAction func loginAction(sender: AnyObject) {
        let email = self.usernameField.text
        let password = self.passwordField.text
        let login = AuthenticationOperation(url: NSURL(string:"http://45.55.37.26:3000/ios_login")!)
        login.logIn(email!, password: password!){ (let loginUser) in
            //Assign the user to be passed around
            if loginUser != nil{
                self.user = loginUser
                //perform segue on main thread
                dispatch_async(dispatch_get_main_queue(), { () -> Void in 
                    /*If the user has not already signed in then save their log in info*/
                   if !(NSUserDefaults.standardUserDefaults().boolForKey("signedIn")){
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "signedIn")
                        NSUserDefaults.standardUserDefaults().setObject(self.usernameField.text, forKey: "username")
                        self.MyKeyChainWrapper.mySetObject(self.passwordField.text, forKey: kSecValueData)
                        print("User saved")
                    }
 
                    //Else get their credentials and log in
                    self.performSegueWithIdentifier("toFrontPostcard", sender: sender)
                })
            }
            else{
                dispatch_async(dispatch_get_main_queue(), {
                    self.invalidLoginLabel.text = "Failed Login"
                })
            }
        }
        //Validate Email which is username
                
    }
    
}
