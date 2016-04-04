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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let contact = user!.contacts![indexPath.row] as? NSDictionary
        let name = "\(contact!["first_name"]!) \(contact!["last_name"]!)"
        
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
        return user!.contacts!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .Checkmark
            {
                cell.accessoryType = .None
                
            }
            else
            {
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
            print(self.text)
        }
    }
    
    
}
