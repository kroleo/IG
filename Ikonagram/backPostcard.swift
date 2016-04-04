//
//  backPostcard.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//


import UIKit
var final_text: String!
class backPostcard: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var edit: UITextField!
    
    var user: User?
    @IBAction func font1(sender: UIButton) {
        message.font = UIFont(name: "Chalkboard", size: 15)
    }
    @IBOutlet weak var message: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let getContacts = AuthenticationOperation(url: NSURL(string:"http://45.55.37.26:3000/ios_get_contacts/?id=\(self.user!.id)")!)
        getContacts.getContacts(user!.id){ (let contacts) in
            dispatch_async(dispatch_get_main_queue(),{
                self.user!.add_contacts(contacts)
            })
        }
        self.edit.delegate = self;
    }
    
    @IBAction func editor(sender: UITextField) {
        self.message.text = sender.text
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        scrollview.setContentOffset(CGPointMake(0, 200), animated: true)
//    }
//    
//    func textFieldDidEndEditing(textField: UITextField) {
//        scrollview.setContentOffset(CGPointMake(0, 0), animated: true)
//    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func toStep3(sender: UIButton) {
        final_text = self.message.text
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toContacts"{
            print(self.user!.contacts)
            let destination = segue.destinationViewController as? selectContacts
            print(self.edit.text)
            destination!.user = self.user
            destination!.text = self.edit.text
        }
    }
}