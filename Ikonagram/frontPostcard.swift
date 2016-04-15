//
//  frontPostcard.swift
//  Ikonagram
//
//  Created by Harsha Cuttari on 2/24/16.
//  Copyright © 2016 Kroleo Studios. All rights reserved.
//

import UIKit
var previewImage : UIImage?
class frontPostcard: UIViewController, UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    @IBOutlet weak var CollectionView: UIView!
    var CurrentMode :Int = 1
    enum collectionMode: Int {
        case SingleMode = 1
        case DoubleMode = 2
        case TripleMode = 3
    }
    var singleimage_view: SingleImageView?
    var twoImages_View: TwoImagesView?
    var threeImages_View: ThreeImagesView?
    var previewImageSize: CGSize!
    var user: User?
    var postcard: Postcard?
    var previewImage: UIImage?
    
    @IBAction func toStep2(sender: AnyObject) {
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(CollectionView.bounds.size.width, CollectionView.bounds.size.height), false, 0);
        CollectionView.drawViewHierarchyInRect(CGRectMake(0,0,CollectionView.bounds.size.width,CollectionView.bounds.size.height), afterScreenUpdates: true)
        previewImage = UIGraphicsGetImageFromCurrentImageContext();
        previewImage = self.scaleImageToSize(previewImageSize, sourceImage: previewImage!)
        self.previewImage = previewImage!
        self.performSegueWithIdentifier("backPostcard", sender: sender)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.user != nil{
            print("We have a user")
        }
        else{
            print("No user")
        }
        previewImageSize = CGSizeMake(861, 528)
        self.addSingleModeView()
        
        
    }
    
    @IBAction func btn_one(sender: AnyObject) {
        CurrentMode = 1
        addCollectionViewToController()
    }
    
    @IBAction func btn_two(sender: AnyObject) {
        CurrentMode = 2
        addCollectionViewToController()
    }
    
    @IBAction func btn_three(sender: AnyObject) {
        CurrentMode = 3
        addCollectionViewToController()
    }
    
    
    func removeSubviewFromScrollView (myScrollView :UIView)
    {
        for imgView :UIView in myScrollView.subviews
        {
            imgView.removeFromSuperview()
        }
    }
    
    func addSingleModeView()
    {
        singleimage_view = SingleImageView()
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "SingleImageView", bundle: bundle)
        singleimage_view = nib.instantiateWithOwner(self, options: nil)[0] as? SingleImageView
        singleimage_view?.frame = self.CollectionView.bounds
        self.CollectionView.addSubview(singleimage_view!)
    }
    
    func addDoubleModeView()
    {
        twoImages_View = TwoImagesView()
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "TwoImagesView", bundle: bundle)
        twoImages_View = nib.instantiateWithOwner(self, options: nil)[0] as? TwoImagesView
        twoImages_View?.frame = self.CollectionView.bounds
        self.CollectionView.addSubview(twoImages_View!)
    }
    
    func addTripleModeView()
    {
        threeImages_View = ThreeImagesView()
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "ThreeImagesView", bundle: bundle)
        threeImages_View = nib.instantiateWithOwner(self, options: nil)[0] as? ThreeImagesView
        threeImages_View?.frame = self.CollectionView.bounds
        self.CollectionView.addSubview(threeImages_View!)
    }
    
    func addCollectionViewToController()
    {
        self.removeSubviewFromScrollView(self.CollectionView)
        switch(CurrentMode){
        case collectionMode.SingleMode.rawValue:
            self.addSingleModeView()
            break
        case collectionMode.DoubleMode.rawValue :
            self.addDoubleModeView()
            break
        case collectionMode.TripleMode.rawValue :
            self.addTripleModeView()
            break
        default :
            print("invalid mode")
            self.addSingleModeView()
        }
    }
    
    func scaleImageToSize(newSize:CGSize , sourceImage:UIImage)->UIImage  {
        
        let oldWidth:CGFloat = sourceImage.size.width
        let scaleFactor:CGFloat = newSize.width / oldWidth;
        
        let newHeight:CGFloat = sourceImage.size.height * scaleFactor;
        let newWidth:CGFloat = oldWidth * scaleFactor;
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
        sourceImage.drawInRect(CGRectMake(0, 0, newWidth, newHeight));
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "settingsSegue" {
            let destination = segue.destinationViewController as? SettingsView
            destination!.user = self.user
        }
        if segue.identifier == "backPostcard"{
            let destination = segue.destinationViewController as? backPostcard
            destination!.user = self.user
            self.postcard = Postcard(first: self.previewImage!)
            destination!.postcard = self.postcard
        }
    }
    
    
}