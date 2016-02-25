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
    
    @IBAction func font1(sender: UIButton) {
        message.font = UIFont(name: "Chalkboard", size: 15)
        
    }
    @IBOutlet weak var message: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
}
