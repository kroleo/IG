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
    
    var theImage: UIImage?
    var finalText: String?
    var postcard: Postcard?
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = self.postcard?.message
        image.image = self.postcard?.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func pay(sender: UIButton) {
        let picturePost = AuthenticationOperation(url: NSURL(string:"http://45.55.37.26:3000/ios_post_photo")!)
        picturePost.postPhoto((self.postcard?.image!)!, user: self.user!,message: self.postcard!.message!)
    }

}


