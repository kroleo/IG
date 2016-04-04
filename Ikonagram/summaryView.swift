//
//  summaryView.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit


class summaryView: UIViewController{
    
    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var text: UILabel!
    
    var finalText: String?
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(finalText)
        text.text = finalText!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func pay(sender: UIButton) {
        
        
    }

}


