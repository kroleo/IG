//
//  EditContacts.swift
//  Ikonagram
//
//  Created by cole alban on 4/25/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import Foundation
import UIKit

class EditContacts: UIViewController, EditContactDelegate{
    //--Instance Variables--//
    var contact: Contact?
    var user: User?
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var nation: UITextField!
    
    //Will add the user for this view controller
    func addUser(user: User) {
        self.user = user
    }
    
    //This will set the contact to use
    func addContact(contact: Contact) {
        self.contact = contact
    }
    
    //--UI Methods--/
    
    //Set up view with initial values of contact
    override func viewDidLoad() {
        self.firstName.text = self.contact!.first_name
        self.lastName.text = self.contact!.last_name
        self.street.text = self.contact!.street
        self.city.text = self.contact!.city
        self.state.text = self.contact!.state
        self.zip.text = self.contact!.zip
        self.nation.text = self.contact!.nation
        
    }
    
    //This will submit the user to be saved
    @IBAction func editContact(sender: AnyObject) {
        if let navigationController = self.navigationController
        {
            navigationController.popViewControllerAnimated(true)
            let contactOperation = AuthenticationOperation(url: NSURL(string:"http://45.55.37.26:3000/ios_edit_contact")!)
            contactOperation.editContact(self.user!.id, firstName: firstName.text!, lastName: lastName.text!, street: street.text!, city: city.text!, zip: zip.text!, nation: nation.text!, state: state.text!,contact_id: self.contact!.id!, completionHandler: {
            })
            
        }
    }
    
    //Send the user back to select contacts
    @IBAction func cancelAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}