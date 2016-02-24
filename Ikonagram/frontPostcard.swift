//
//  frontPostcard.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit

class frontPostcard: UIViewController {
    
    
    @IBOutlet weak var layout1: UIView!
    @IBOutlet weak var layout2: UIView!
    @IBOutlet weak var layout3: UIView!
    
    
    @IBAction func selectLayout1(sender: UIButton) {
        layout1.hidden = false
        layout2.hidden = true
        layout3.hidden = true
        
    }
    @IBAction func selectLayout2(sender: UIButton) {
        layout1.hidden = true
        layout2.hidden = false
        layout3.hidden = true
        
    }
    @IBAction func selectLayout3(sender: UIButton) {
        layout1.hidden = true
        layout2.hidden = true
        layout3.hidden = false
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
