//
//  AuthenticationOperation.swift
//  Ikonagram
//
//  Created by cole alban on 4/1/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import Foundation
import UIKit
/*
This class will be used for authentication posts
This will allow for creation of new users and objects in the database
*/
class AuthenticationOperation: NetWorkOperation{
    //This function handles sign ups
    func signUp(firstName: String,lastName: String, password: String, email: String, completionHandler: (val: Bool)->()){
        print(self.url)
        //create a mutable request and set the options for the HTTP request
        let request = NSMutableURLRequest(URL: self.url)
        request.HTTPMethod = "POST"
        let params = ["firstName":firstName,"lastName":lastName,"email":email,"password":password]
        request.HTTPBody = try!NSJSONSerialization.dataWithJSONObject(params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //Create a network task on the backend and check the response for completion or failure
        let task =  self.session.dataTaskWithRequest(request){(let data, let resp, let error) in
            if let respHTTP =  resp as? NSHTTPURLResponse{
                if respHTTP.statusCode == 200 {
                    print("User created")
                    completionHandler(val: true)
                }
                else if(respHTTP.statusCode == 400){
                    print("User could not save")
                    completionHandler(val: false)
                }
                else{
                    completionHandler(val: false)
                    print("Bad request")
                }
            }
        }
        task.resume()
        
        
        
    }
    
    //This function will handle login for users
    func logIn(email: String, password: String, completionHandler: (user: User?)->()){
        let request = NSMutableURLRequest(URL: self.url)
        request.HTTPMethod = "POST"
        let params = ["email":email, "password":password]
        request.HTTPBody = try!NSJSONSerialization.dataWithJSONObject(params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task1 = self.session.dataTaskWithRequest(request){ (let data, let resp, let error) in
            if let respHTTP = resp as? NSHTTPURLResponse{
                if respHTTP.statusCode == 200{
                    let JSONDictionary = try!NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                    let theUser = User(dictionary: JSONDictionary!)
                    completionHandler(user: theUser)
                }
                else{
                    completionHandler(user: nil)
                }
            }
        }
        task1.resume()
    }
    
    //This functionw will allow users to add contacts
    func addContact(id: Int,firstName: String, lastName: String, street: String, city: String, zip: String, nation: String,state: String, completionHandler: ()->()){
        let request = NSMutableURLRequest(URL: self.url)
        let params = ["id":id, "first_name":firstName, "last_name":lastName,"street":street,"city":city,"zip":zip,"nation":nation, "state":state]
        request.HTTPMethod = "POST"
        request.HTTPBody = try!NSJSONSerialization.dataWithJSONObject(params, options: [])
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = self.session.dataTaskWithRequest(request){(let data, let resp, let error) in
            if let respHTTP = resp as? NSHTTPURLResponse{
                if respHTTP.statusCode == 200{
                    
                }
                else{

                }
            }
        }
        task.resume()
    }
    
    //This function will get contacts
    func getContacts(id: Int,completionHandler: (NSArray)->()){
        print(self.url)
        let request = NSURLRequest(URL: self.url)
        let task = self.session.dataTaskWithRequest(request){(let data, let resp, let error) in
            if let JSONData = try!NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray{
                print(JSONData)
                completionHandler(JSONData)
            }
        }
        task.resume()
    }
    
    //This function will handle the posting of the photo
    func postPhoto(image: UIImage, user: User, message: String){
        
        //Turn the UIImage into its encoded representation and prepare for request
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let request = NSMutableURLRequest(URL: self.url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPMethod = "POST"
        let base64String = (imageData?.base64EncodedStringWithOptions([NSDataBase64EncodingOptions(rawValue: 0)]))! as String
        //Create a timestamp to send along with the photo to be saved in the database
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        let params = ["content_type":"image/jpeg","filename":"\(timestamp)\(user.email)","file_data":base64String,"user":user.id,"message":message]
        request.HTTPBody = try!NSJSONSerialization.dataWithJSONObject(params, options: [])
        print("Ready for response")
        let task = self.session.dataTaskWithRequest(request){ (let data, let resp, let error) in
            if let respHTTP = resp as? NSHTTPURLResponse{
                print(respHTTP)
            }
        }
        task.resume()
    }
    
}