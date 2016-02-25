//
//  CustomeScrollView.swift
//  ImageCollection
//
//  Created by Muhammad Dawood on 17/01/2016.
//  Copyright © 2016 Human Focus. All rights reserved.
//

import UIKit

class CustomeScrollView: UIScrollView ,UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    var ImageView:UIImageView?
    var lastScale :CGFloat?
    var addImageButton : UIButton?

    override func drawRect(rect: CGRect) {
        self.minimumZoomScale = 1.0
        self.maximumZoomScale = 6.0
        let pinch:UIPinchGestureRecognizer!=UIPinchGestureRecognizer(target: self, action:"scaleView:");
        self.addGestureRecognizer(pinch)
        self.userInteractionEnabled = true
        self.delegate = self
        lastScale = self.frame.size.width / self.bounds.size.width
        addImageButton = UIButton(frame: CGRectMake(0, 0, 200, 200))
        addImageButton?.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        addImageButton?.setTitle("Add Image", forState: UIControlState.Normal)
        addImageButton?.backgroundColor = UIColor.yellowColor()
        addImageButton?.addTarget(self, action: "addImageButtonTap", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    @IBAction func scaleView(sender: UIPinchGestureRecognizer) {
        
        var newScale : CGFloat!
        if self.ImageView != nil{
        if sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Changed {
            newScale = lastScale! * sender.scale;
            if (newScale < self.minimumZoomScale) {
                newScale = self.minimumZoomScale;
            }
            if (newScale > self.maximumZoomScale) {
                newScale = self.maximumZoomScale;
            }
            self.zoomScale = newScale
            lastScale = newScale
        }
        }
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.ImageView
    }
    func setImageInScrollView (selectedImage:UIImage)
    {
        self.ImageView = UIImageView(image: selectedImage)
        self.ImageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubview(self.ImageView!)
        self.bringSubviewToFront(self.ImageView!)
        self.contentMode=UIViewContentMode.ScaleAspectFit
        self.ImageView!.sizeToFit()
        self.ImageView!.frame = self.bounds
    }
    func addImageButtonTap()
    {
        
    }
   
}
protocol cutomeScrollViewDelegates{
    func showImagePickerViewController()
    
}
