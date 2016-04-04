//
//  ThreeImagesView.swift
//  ImageCollection
//
//  Created by Muhammad Dawood on 18/01/2016.
//  Copyright © 2016 Human Focus. All rights reserved.
//

import UIKit

class ThreeImagesView: UIView,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var firstScrollView: CustomeScrollView!
    @IBOutlet weak var secondScrollView: CustomeScrollView!
    @IBOutlet weak var thirdScrollView: CustomeScrollView!
   
    @IBOutlet weak var btn_addImage1: UIButton!
    @IBOutlet weak var btn_addImage2: UIButton!
    @IBOutlet weak var btn_addImage3: UIButton!
    
    var selectedScrollView :CustomeScrollView!
    var selectedButton : UIButton!
    override func drawRect(rect: CGRect) {
        self.btn_addImage1.addTarget(self, action: "addImageButton1Tap", forControlEvents: UIControlEvents.TouchUpInside)
        self.btn_addImage2.addTarget(self, action: "addImageButton2Tap", forControlEvents: UIControlEvents.TouchUpInside)
        self.btn_addImage3.addTarget(self, action: "addImageButton3Tap", forControlEvents: UIControlEvents.TouchUpInside)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.blackColor().CGColor
    }
    func addImageButton1Tap ()
    {
        self.selectedButton = btn_addImage1
        self.selectedScrollView = firstScrollView
        if self.firstScrollView.ImageView != nil {
            self.showWarninigAlertIfImageAlreadyExist(1)
        }else{
            self.showImageAddingAlert()
        }
    }
    func addImageButton2Tap ()
    {
        self.selectedButton = btn_addImage2
        selectedScrollView = secondScrollView
        if self.secondScrollView.ImageView != nil {
            self.showWarninigAlertIfImageAlreadyExist(2)
        }else{
            self.showImageAddingAlert()
        }
    }
    func addImageButton3Tap ()
    {
        self.selectedButton = btn_addImage3
        selectedScrollView = thirdScrollView
        if self.thirdScrollView.ImageView != nil {
            self.showWarninigAlertIfImageAlreadyExist(3)
        }else{
            self.showImageAddingAlert()
        }
    }
    func showWarninigAlertIfImageAlreadyExist (tag:Int){
        let alert:UIAlertController! = UIAlertController(title: "Photo already exist", message: "Are you sure tou want to replace photo no:\(tag)", preferredStyle: UIAlertControllerStyle.Alert)
        let yesAction :UIAlertAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.showImageAddingAlert()
        }
        let noAction : UIAlertAction = UIAlertAction(title: "NO", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
        }
        alert.addAction(yesAction)
        alert.addAction(noAction)
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true , completion: nil)
    }
    
    func showImageAddingAlert()
    {
        let alert:UIAlertController! = UIAlertController(title: "Add Photo", message: "Please select an action", preferredStyle: UIAlertControllerStyle.Alert)
        let capturePhotAction :UIAlertAction = UIAlertAction(title: "Capture Photo", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.loadImagePicker(true)
        }
        let attachPhotoAction : UIAlertAction = UIAlertAction(title: "Attach Photo", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.loadImagePicker(false)
        }
        let CancelAction : UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            
        }
        alert.addAction(capturePhotAction)
        alert.addAction(attachPhotoAction)
        alert.addAction(CancelAction)
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func loadImagePicker(isLoadFromCamera : Bool)
    {
        let imagePicker :UIImagePickerController! = UIImagePickerController()
        if isLoadFromCamera{
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            }
            else{
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            }
        }
        else
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        imagePicker.delegate = self
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(imagePicker, animated: true, completion: nil)
        
        
    }
    
    //MARK:- Image Picker Delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        self.removeSubviewFromScrollView(selectedScrollView)
        self.selectedScrollView.setImageInScrollView(image)
        self.selectedButton.hidden = true
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func removeSubviewFromScrollView (myScrollView :UIView)
    {
        for imgView :UIView in myScrollView.subviews
        {
            imgView.removeFromSuperview()
        }
    }


}
