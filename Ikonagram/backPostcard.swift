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
    
    var image: UIImage?
    
    var user: User?
    var postcard: Postcard?
    @IBAction func font1(sender: UIButton) {
        message.font = UIFont(name: "Chalkboard", size: 15)
    }
    @IBOutlet weak var message: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let theUser = user {
        let getContacts = AuthenticationOperation(url: NSURL(string:"http://45.55.37.26:3000/ios_get_contacts/?id=\(theUser.id)")!)
        getContacts.getContacts(user!.id){ (let contacts) in
            dispatch_async(dispatch_get_main_queue(),{
                self.user!.add_contacts(contacts)
            })
        }
        }
        else{
            print("No user")
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
    
  //func textFieldDidBeginEditing(textField: UITextField) {
    //        scrollview.setContentOffset(CGPointMake(0, 200), animated: true)
    //}
//    
 //   func textFieldDidEndEditing(textField: UITextField) {
   //     scrollview.setContentOffset(CGPointMake(0, 0), animated: true)
   // }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    @IBAction func toStep3(sender: UIButton) {
        self.postcard!.addMessage(self.edit!.text!)
        performSegueWithIdentifier("toContacts", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toContacts"{
            print("Passing in the user")
            let destination = segue.destinationViewController as? selectContacts
            destination!.user = self.user
            destination!.postcard = self.postcard
        }
    }
}