//
//  addContacts.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit
/*
 This is a controller for the add contacts scene
 */

class addContacts: UIViewController {
    //--INSTANCE VARIABLES--//

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var nation: UITextField!
    
    var user: User?
    
    
    //--MEMORY AND LOADING FUNCTION--//
    /*
     Run this function on the loading of the page
     includes various things used to setup the page
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstName.autocorrectionType = UITextAutocorrectionType.No
        self.lastName.autocorrectionType = UITextAutocorrectionType.No
        self.street.autocorrectionType = UITextAutocorrectionType.No
        self.city.autocorrectionType = UITextAutocorrectionType.No
        self.state.autocorrectionType = UITextAutocorrectionType.No
        self.zip.autocorrectionType = UITextAutocorrectionType.No
        self.nation.autocorrectionType = UITextAutocorrectionType.No
        self.hideKeyboardWhenTapped()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //--BUTTON ACTIONS--//
    
    
    /*
     This will be used if the user wishes to cancel the add contact action
     will pop the view off the stack
    */
    @IBAction func cancel(sender: UIButton) {
        if let navigationController = self.navigationController
        {
            navigationController.popViewControllerAnimated(true)
        }
    }
    
    
    /*
    This function will be run when a user saves a new contact
     It will create a network object to interact with the server and 
     create a contact via the API
    */
    @IBAction func save(sender: AnyObject) {
        if let navigationController = self.navigationController
        {
            navigationController.popViewControllerAnimated(true)
            let contactOperation = AuthenticationOperation(url: NSURL(string:"http://45.55.37.26:3000/ios_add_contact")!)
            contactOperation.addContact(self.user!.id, firstName: firstName.text!, lastName: lastName.text!, street: street.text!, city: city.text!, zip: zip.text!, nation: nation.text!, state: state.text!,completionHandler: {
                
                
            })
            
        }
        
    }
}
