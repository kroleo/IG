//
//  LoginSlides.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/23/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit

class LoginSlides: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    var pageIndex: Int!
    var imageFile: String!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.imageView.image = UIImage(named: self.imageFile)

        
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
