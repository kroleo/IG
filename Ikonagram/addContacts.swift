//
//  addContacts.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit
import Parse

class addContacts: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func cancel(sender: UIButton) {
        if let navigationController = self.navigationController
        {
            navigationController.popViewControllerAnimated(true)
        }
    }
    @IBAction func save(sender: AnyObject) {
        if let navigationController = self.navigationController
        {
            navigationController.popViewControllerAnimated(true)
        }
        PFUser.currentUser()?.addObject(name.text!, forKey: "contactNames")
        PFUser.currentUser()?.saveInBackground()
        contacts.append(name.text!)
        PFUser.currentUser()?.addObject(address.text!, forKey: "contactAddresses")
        PFUser.currentUser()?.saveInBackground()
        //navigationController?.popViewControllerAnimated(true)

    }
}
