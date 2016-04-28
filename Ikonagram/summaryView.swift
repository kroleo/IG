//
//  summaryView.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit
import Braintree

class summaryView: UIViewController, BTDropInViewControllerDelegate {
    var braintreeClient: BTAPIClient?
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var cost: UILabel!

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var text: UILabel!
    
    var theImage: UIImage?
    var messageImage: UIImage?
    var finalText: String?
    var postcard: Postcard?
    var user: User?
    var contacts: [Contact]?
    var userDidCancel: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = self.postcard?.message
        text.font = self.postcard?.font
        image.image = self.postcard?.image
        let urlString = "http://45.55.37.26:3000/client_token"
        let clientTokenOperation = AuthenticationOperation(url: NSURL(string: urlString)!)
        clientTokenOperation.getClientToken(){ (let token) in
            print(token)
            self.braintreeClient = BTAPIClient(authorization: token)
        }
        let costString = String(3*self.contacts!.count)
        cost.text = "$\(costString)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func pay(sender: UIButton) {
        // If you haven't already, create and retain a `BTAPIClient` instance with a
        // tokenization key OR a client token from your server.
        // Typically, you only need to do this once per session.
        
        // Create a BTDropInViewController
        let dropInViewController = BTDropInViewController(APIClient: braintreeClient!)
        dropInViewController.delegate = self
        
        // This is where you might want to customize your view controller (see below)
        
        // The way you present your BTDropInViewController instance is up to you.
        // In this example, we wrap it in a new, modally-presented navigation controller:
        dropInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Cancel,
            target: self, action: "PaymentController.userDidCancelPayment")
        let navigationController = UINavigationController(rootViewController: dropInViewController)
        presentViewController(navigationController, animated: true, completion: nil)
        
        let picturePost = AuthenticationOperation(url: NSURL(string:"http://45.55.37.26:3000/ios_post_photo")!)
        var contactIds: [Int] = []
        if let contactList = self.contacts{
            for i in contactList{
                contactIds.append(i.id!)
            }
        }
        print(contactIds)
        if !(self.userDidCancel){
            picturePost.postPhoto((self.postcard?.image!)!, user: self.user!,message: self.postcard!.message!)
            self.performSegueWithIdentifier("toConfirmation", sender: sender)
        }
        else{
            print("User backed out")
        }
    }
    
    /*
    Methods for the braintree stuff go down here*/
    
    func userDidCancelPayment() {
        print("User cancelled")
        self.userDidCancel = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dropInViewController(viewController: BTDropInViewController,
                              didSucceedWithTokenization paymentMethodNonce: BTPaymentMethodNonce)
    {
        // Send payment method nonce to your server for processing
        postNonceToServer(paymentMethodNonce.nonce)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dropInViewControllerDidCancel(viewController: BTDropInViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postNonceToServer(paymentMethodNonce: String) {
        let paymentURL = NSURL(string: "http://45.55.37.26:3000/checkout")!
        let request = NSMutableURLRequest(URL: paymentURL)
        request.HTTPBody = "payment_method_nonce=\(paymentMethodNonce)".dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
            }.resume()
    }

}


