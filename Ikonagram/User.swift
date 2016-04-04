//
//  User.swift
//  Ikonagram
//
//  Created by cole alban on 4/2/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import Foundation

struct User{
    let firstName: String
    let lastName: String
    let email: String
    let id: Int
    var contacts: NSArray?
    
    //This initializer will take in information returned from the login step
    init(dictionary: [String: AnyObject?]){
        self.firstName = dictionary["firstName"] as! String
        self.lastName = dictionary["lastName"] as! String
        self.email = dictionary["email"] as! String
        self.id = dictionary["id"] as! Int
        //contacts = nil
    }
    
    mutating func add_contacts(contactArray: NSArray){
        contacts = contactArray
    }
}