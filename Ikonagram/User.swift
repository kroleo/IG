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
    var contacts: [Contact]
    
    //This initializer will take in information returned from the login step
    init(dictionary: [String: AnyObject?]){
        self.firstName = dictionary["firstName"] as! String
        self.lastName = dictionary["lastName"] as! String
        self.email = dictionary["email"] as! String
        self.id = dictionary["id"] as! Int
        contacts = []
    }
    
    //This adds contact to the users contacts array
    mutating func add_contacts(contactArray: NSArray){
        for i in contactArray{
            let newContact = Contact(contact: i as! NSDictionary)
            self.contacts.append(newContact)
        }
    }
    
    //This function can find contacts in the array by name and return their id
    func find_by_full_name(search_name: String)->Contact?{
        for i in contacts{
            if search_name == i.full_name {
                //return the contact if contact found
                return i
            }
        }
        //Return nil if not found
        return nil
    }
}