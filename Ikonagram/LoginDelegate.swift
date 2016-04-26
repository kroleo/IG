//
//  LoginDelegate.swift
//  Ikonagram
//
//  Created by cole alban on 4/25/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import Foundation

protocol LoginDelegate{
    //This will clear out the username and password fields
    func resetFields()
    
    //This will set the login fields
    func setFields(username: String, password: String)
}