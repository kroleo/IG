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
    var delegate: MessageSender?
    var image: UIImage?
    var myMessage: String?
    
    var user: User?
    var postcard: Postcard?
    
    /*These IBActions will change the font being used to edit*/
    @IBAction func font1(sender: UIButton) {
        edit.font = UIFont(name:"ChalkboardSE-Regular", size: 15)
    }
    
    @IBAction func font2(sender: AnyObject) {
        edit.font = UIFont(name: "BradleyHandITCTT-Bold", size: 15)
    }
    
    
    @IBAction func font3(sender: AnyObject) {
        edit.font = UIFont(name: "HelveticaNeue", size: 15)
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
        if let msg = self.myMessage{
            self.edit.text = msg
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
    
    //Send message back when popping view
    override func viewDidDisappear(animated: Bool) {
        delegate!.addMessage(self.edit.text!)
    }
    

    @IBAction func toStep3(sender: UIButton) {
        self.postcard!.addMessage(self.edit!.text!)
        performSegueWithIdentifier("toContacts", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toContacts"{
            let destination = segue.destinationViewController as? selectContacts
            self.postcard?.addFont(edit.font)
            destination!.user = self.user
            destination!.postcard = self.postcard
        }
    }
    
    
}

/*
 This protocol will be used to implement 
 a delegate for keeping track of messages
 */
protocol MessageSender{
    func addMessage(message: String)
}