//
//  summaryView.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit
import Parse

class summaryView: UIViewController, PayPalPaymentDelegate{
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var text: UILabel!

    
    var payPalConfig = PayPalConfiguration()
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }
    
    var acceptCreditCards: Bool = true {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        PayPalMobile.initializeWithClientIdsForEnvironments([PayPalEnvironmentProduction: "abc", PayPalEnvironmentSandbox: "xyz"])

        // Do any additional setup after loading the view.
        
        self.image.image = previewImage
//        self.image.sizeToFit()
        self.text.text = final_text
/*
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "Kroleo Studios Inc."
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.sivaganesh.com/privacy.html")
        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.sivaganesh.com/useragreement.html")
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages()[0]
        payPalConfig.payPalShippingAddressOption = .PayPal;
        
        PayPalMobile.preconnectWithEnvironment(environment)
        
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        print("PayPal Payment Cancelled")
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        
        print("PayPal Payment Success !")
        paymentViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
        })
    }
    
    
    @IBAction func pay(sender: UIButton) {
        
            let cardsClass = PFObject(className: "Cards")
            cardsClass["message"] = final_text
        
        if previewImage != nil {
            let imageData = UIImageJPEGRepresentation(previewImage!, 0.5)
            let imageFile = PFFile(name:"image.jpg", data:imageData!)
            cardsClass["picture1"] = imageFile
            
            
            cardsClass.saveInBackgroundWithBlock { (success, error) -> Void in
                if error == nil {
                    //self.view.hideHUD()
                    //self.openMailVC()
                    // will send as message
                } else {
                    let alert = UIAlertView(title: APP_NAME,
                        message: "\(error!.localizedDescription)",
                        delegate: nil,
                        cancelButtonTitle: "OK" )
                    alert.show()
                    //self.view.hideHUD()
                } }
        }

        
        
        
        
        
        
        
/*
        // Process Payment once the pay button is clicked.
        
        let item1 = PayPalItem(name: "Postcard", withQuantity: 1, withPrice: NSDecimalNumber(string: "5.99"), withCurrency: "USD", withSku: "0001")
        
        let items = [item1]
        let subtotal = PayPalItem.totalPriceForItems(items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "0.00")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.decimalNumberByAdding(shipping).decimalNumberByAdding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Medium Size Postcard", intent: .Sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            presentViewController(paymentViewController!, animated: true, completion: nil)
        }
        else {
            
            print("Payment not processalbe: \(payment)")
        }
*/
    }


}