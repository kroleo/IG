//
//  NetworkOperation.swift
//  Ikonagram
//
//  Created by cole alban on 4/1/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

/*
*This is a superclass which will serve as the model for network operations
*Built to interface with the Ikonagram API
*/

import Foundation

class NetWorkOperation{
    //Create a session with default configs and a URL instance variable
    lazy var session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    let url: NSURL
    
    //Basic initalizer that will simply set the URL
    init(url: NSURL){
        self.url = url
    }
    
    

}
