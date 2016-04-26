//
//  Contact.swift
//  Ikonagram
//
//  Created by cole alban on 4/15/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import Foundation

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
    
    init(contact: NSDictionary){
        print(contact)
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
}
