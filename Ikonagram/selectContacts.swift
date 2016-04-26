//
//  selectContacts.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit

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
    var editContact: Bool?
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
    
    /*
    Action that will send user to add contacts page
    */
    @IBAction func toAddContacts(sender: AnyObject) {
        self.performSegueWithIdentifier("addContacts", sender: sender)
    }
    
   
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func toSummary(sender: AnyObject) {
        performSegueWithIdentifier("toSummary", sender: sender)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user!.contacts.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if (self.editContact!){
                let contact = user?.find_by_full_name(cell.textLabel!.text!)
                if let theContact = contact{
                    self.contactToSend = theContact
                }
                performSegueWithIdentifier("toEditContact", sender: self)
            }
            else{
            if cell.accessoryType == .Checkmark
            {
                cell.accessoryType = .None
                
                
                
            }
            else
            {
                let contact = user?.find_by_full_name(cell.textLabel!.text!)
                if let theContact = contact{
                    self.contacts.append(theContact)
                    print("Contact Added")
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
            destination!.user = self.user
        }
        if segue.identifier == "toSummary"{
            let destination = segue.destinationViewController as? summaryView
            print("Boutta go to summary")
            print(self.contacts)
            destination!.user = self.user
            destination!.finalText = self.text
            destination!.theImage = self.image
            destination!.postcard = self.postcard
            destination!.contacts = self.contacts
        }
        if segue.identifier == "toEditContact"{
            let destination = segue.destinationViewController as? EditContacts
            self.delegate = destination
            delegate!.addUser(self.user!)
            delegate!.addContact(self.contactToSend!)
        }
    }
    
    //--UI Methods--//
    
    //When a user starts this action, edit mode will be enabled
    @IBAction func startEditMode(sender: AnyObject) {
        self.editContact! = !self.editContact!
        if self.editContact! {
            self.editButton.setTitle("Editing", forState: UIControlState.Normal)
        }
        else{
            self.editButton.setTitle("Edit", forState: UIControlState.Normal)
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
}
