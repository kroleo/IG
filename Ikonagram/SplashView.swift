//
//  ViewController.swift
//  UIPageViewController
//
//  Created by PJ Vea on 3/27/15.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit

class SplashView: UIViewController {
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Go to login page
    @IBAction func toLogin(sender: AnyObject) {
        performSegueWithIdentifier("toLogin", sender: sender)
    }
    
    //Go to signup page
    @IBAction func toSignUp(sender: AnyObject) {
        performSegueWithIdentifier("toSignUp", sender: sender)
    }
}

