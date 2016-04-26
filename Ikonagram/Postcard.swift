//
//  Postcard.swift
//  Ikonagram
//
//  Created by cole alban on 4/13/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import Foundation
import UIKit

/*
 This class will serve as a data structure for Postcards
 different init methods will handle the different postcard orientations
 These will correspond to different uploading methods as well
 */
class Postcard{
    //Creating these images as optionals in case nothing is passed in for one
    let image: UIImage?
    var message: String?
    var font: UIFont?
    
    //Single image
    init(first: UIImage?){
        image = first
        message = nil
    }
    
    //Add a message to an existing postcard
    func addMessage(message: String){
        self.message = message
    }
    
    //This will allow the font to be updated
    func addFont(font: UIFont?){
        self.font = font
    }
}
