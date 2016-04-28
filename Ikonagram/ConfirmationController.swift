//
//  ConfirmationController.swift
//  Ikonagram
//
//  Created by cole alban on 4/22/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//


import UIKit

class ConfirmationController: UIViewController{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func createAnother(sender: AnyObject) {
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: false)
    }

    
    @IBAction func logout(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "signedIn")
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
}