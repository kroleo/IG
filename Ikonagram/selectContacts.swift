//
//  selectContacts.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit

/*
This class will be used on the select contacts scene
 */

class selectContacts: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //--Instance Variables--//
    @IBOutlet weak var tableView: UITableView!
    var user: User?
    var text: String?
    var image: UIImage?
    var postcard: Postcard?
    var delegate: EditContactDelegate?
    var contacts: [Contact] = []
    var contactToSend: Contact?
    var editContact: Bool = false
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.editContact = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //--BUTTON ACTIONS--//
    
    /*
    Action that will send user to add contacts page
    */
    @IBAction func toAddContacts(sender: AnyObject) {
        self.performSegueWithIdentifier("addContacts", sender: sender)
    }
    
   
    
    /*
     Segue the user to the summary view.
    */
    @IBAction func toSummary(sender: AnyObject) {
        performSegueWithIdentifier("toSummary", sender: sender)
    }
    
    //--TABLE VIEW FUNCTIONS--//
    
    /*
     This will instantiate new table view cells
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        //Get the contact to place in the cell and add their name to the cell 
        let contact = user!.contacts[indexPath.row]
        let name = "\(contact.first_name!) \(contact.last_name!)"
        cell.textLabel?.text = name
        
        if cell.accessoryType == .None {
            cell.accessoryType = .None
        }
            
        else if cell.accessoryType == .Checkmark {
            cell.accessoryType = .Checkmark
        }
        
        return cell
    }
    
    /*
     Table views will only have one section per row.
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     Size of the table will be the size of the contacts array
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user!.contacts.count
    }
    
    /*
     This will add a contact to the selected contacts array if added.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Check that the cell exists first
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            //Perform these actions if not editing the contact
            if (self.editContact){
                //If edit mode is enabled then segue to edit the contact
                let contact = user?.find_by_full_name(cell.textLabel!.text!)
                contactToSend = contact
                performSegueWithIdentifier("toEditContact", sender: self)
            }
            else{
                //If edit mode is disabled then add and remove 
                //The selected contact from the contact to send array
                if cell.accessoryType == .Checkmark{
                    
                    let contact = user?.find_by_full_name(cell.textLabel!.text!)
                    //If the contact is already in the array, find and remove it
                    let index: Int? = self.contactIsInArray(contacts,contact: contact!)
                    if((index) != nil){
                        self.contacts.removeAtIndex(index!)
                    }
 
                    cell.accessoryType = .None
                }
                else{
                    //If the contact is not in the array add it in
                    let contact = user?.find_by_full_name(cell.textLabel!.text!)
                    if let theContact = contact{
                        self.contacts.append(theContact)
                    }
                    cell.accessoryType = .Checkmark
                }
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    //--Navigation methods--//
    
    //This will prepare various segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addContacts"{
            let destination = segue.destinationViewController as? addContacts
            //Set the user to add contacts to
            destination!.user = self.user
        }
        if segue.identifier == "toSummary"{
            let destination = segue.destinationViewController as? summaryView
            //Set the variables for the destination view
            destination!.user = self.user
            destination!.finalText = self.text
            destination!.theImage = self.image
            destination!.postcard = self.postcard
            destination!.contacts = self.contacts
        }
        if segue.identifier == "toEditContact"{
            let destination = segue.destinationViewController as? EditContacts
            self.delegate = destination
            //Add a user adn contact for the edit view
            delegate!.addUser(self.user!)
            delegate!.addContact(self.contactToSend!)
        }
    }
    
    //--UI Methods--//
    //When a user starts this action, edit mode will be enabled
    @IBAction func startEditMode(sender: AnyObject) {
        self.editContact = !self.editContact
        if self.editContact {
            self.editButton.setTitle("Done", forState: UIControlState.Normal)
            self.editButton.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 80/255, alpha: 1)
        }
        else{
            self.editButton.setTitle("Edit", forState: UIControlState.Normal)
            self.editButton.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        }
    }
    
    //This will update the view with the newest contacts
    @IBAction func refreshView(sender: AnyObject) {
        self.user!.contacts = []
        let getContacts = AuthenticationOperation(url: NSURL(string:"http://45.55.37.26:3000/ios_get_contacts/?id=\(self.user!.id)")!)
        getContacts.getContacts(user!.id){ (let contacts) in
            dispatch_async(dispatch_get_main_queue(),{
                self.user!.add_contacts(contacts)
                self.tableView.reloadData()
            })
        }
    }


//--PRIVATE METHODS--//
    
    
    /*
    This function will tell if a contact exists in an array.
     Return index if it exists. Return nil if not.
    */
    func contactIsInArray(contacts: [Contact], contact: Contact)->Int?{
        //Use i to keep track of the index as we traverse the array
        var i = 0
        for currentContact in contacts {
            if currentContact.equals(contact){
                return i
            }
            i += 1;
        }
        return nil
    }
    
}
