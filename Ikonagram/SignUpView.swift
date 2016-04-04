//
//  SignUpView.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//



import UIKit


class SignUpView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    //Make sure the password entry is blotted out
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //dismissKeyboard()
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        firstNameField.delegate = self
        lastNameField.delegate = self
        passwordField.delegate = self
        passwordField.secureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Validate Email/Username
    func isValidEmail(testStr:String) -> Bool {
        
        print("Validate emilId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(testStr)
        
        return result
        
    }
    
    /*
    This IBAction will correspond to the sign in button
    Check if the email is valid and then sign user up
    */
    @IBAction func signUpAction(sender: AnyObject) {
        
        let firstName = self.firstNameField.text
        let lastName = self.lastNameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if isValidEmail(finalEmail){
            //This creates a authentication network operation which will attempt to sign the user up
            let signUpTask = AuthenticationOperation(url: NSURL(string:"http://45.55.37.26:3000/ios_signup")!)
            signUpTask.signUp( firstName!, lastName: lastName!, password: password!, email: finalEmail,completionHandler: {
                //Perform this callback upon successful sign up. This puts it on the main thread
                dispatch_async(dispatch_get_main_queue(), {
                    self.performSegueWithIdentifier("signupToLogin", sender: sender)
                })
                
            })
            
        }
        
               
        
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    }

    
}
