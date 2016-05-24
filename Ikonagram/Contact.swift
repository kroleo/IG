//
//  Contact.swift
//  Ikonagram
//
//  Created by cole alban on 4/15/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import Foundation

/*
 This class will be used to model contacts
 This includes an initialize method to create the user 
 */
class Contact{

    var first_name: String?
    var last_name: String?
    var full_name: String?
    var city: String?
    var street: String?
    var nation: String?
    var zip: String?
    var state: String?
    var id: Int?
    
    /*
    This will initialize a new contact using the 
    parameters passed in via the JSON object
    It will init values to empty if they do 
    not exist
    */
    init(contact: NSDictionary){
        if let name = contact["first_name"]! as? String{
            self.first_name = name
        }
        else{
            self.first_name = ""
        }
        if let name = contact["last_name"]! as? String{
            self.last_name = name
        }
        else{
            self.last_name = ""
        }
        if let contact_id = contact["id"]{
           self.id = contact_id as? Int
        }
        else{
            self.id = -1
        }
        if let city = contact["city"]{
            self.city = city as? String
        }
        else{
            self.city = ""
        }
        if let state = contact["state"]{
            self.state = state as? String
        }
        else{
            self.state = ""
        }
        if let street = contact["street"]{
            self.street = street as? String
        }
        else{
            self.street = ""
        }
        if let zip = contact["zip"]{
            self.zip = zip as? String
        }
        else{
            self.zip = ""
        }
        if let nation = contact["nation"]{
            self.nation = nation as? String
        }
        else{
            self.nation = ""
        }
        
        self.full_name = {
            "\(self.first_name!) \(self.last_name!)"
        }()
        
    }
    
    /*
    This function will check if two contacts are equal
    */
    func equals(contact: Contact)->Bool{
        //If id and full name are equal, they are the same contact
        if (self.id == contact.id && self.full_name == contact.full_name){
            return true
        }
        return false
    }
}
