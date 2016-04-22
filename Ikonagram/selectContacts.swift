//
//  selectContacts.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit

class selectContacts: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var user: User?
    var text: String?
    var image: UIImage?
    var postcard: Postcard?
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
        print(contact)
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
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addContacts"{
            let destination = segue.destinationViewController as? addContacts
            destination!.user = self.user
        }
        if segue.identifier == "toSummary"{
            let destination = segue.destinationViewController as? summaryView
            destination!.user = self.user
            destination!.finalText = self.text
            destination!.theImage = self.image
            destination!.postcard = self.postcard
            destination!.contacts = self.contacts
        }
    }
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
