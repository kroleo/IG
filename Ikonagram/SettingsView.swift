//
//  SettingsView.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//
import UIKit


class SettingsView: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = self.user{
            userNameLabel.text = currentUser.email
        }
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    @IBAction func logOutAction(sender: AnyObject){
        
        // Send a request to log PFUser.logOut()
        
                
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
