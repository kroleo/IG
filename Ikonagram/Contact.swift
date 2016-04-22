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
        if let contact_id = contact["user_id"]{
           self.id = contact_id as? Int
        }
        else{
            self.id = -1
        }
        
        self.full_name = {
            "\(self.first_name!) \(self.last_name!)"
        }()
        
    }
}
