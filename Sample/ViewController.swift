//
//  ViewController.swift
//  Sample
//
//  Created by Aruna M on 05/01/16.
//  Copyright © 2016 aaa. All rights reserved.
//

import UIKit
import AVFoundation


class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
    }


}



class ViewController: UIViewController , UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func craeteImageAction(sender: AnyObject?) {
        
        let image = UIImage(named: "aaa")
        
        let boundsScale = imageView.bounds.size.width / imageView.bounds.size.height
        let imageScale = image!.size.width / image!.size.height
        
        let size = (image?.size)!
        
        var canvasSize = size
        
        if boundsScale > imageScale {
            canvasSize.width =  canvasSize.height * boundsScale
        }else{
            canvasSize.height =  canvasSize.width / boundsScale
        }
        
        let xScale = canvasSize.width / imageView.bounds.width
        let yScale = canvasSize.height / imageView.bounds.height

        let center = CGPointApplyAffineTransform(imageView.center, CGAffineTransformScale(CGAffineTransformIdentity, xScale, yScale))
        
        let xCenter = center.x
        let yCenter = center.y

        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0);
        let context = UIGraphicsGetCurrentContext()!

        //Apply transformation
        CGContextTranslateCTM(context, xCenter, yCenter)

        CGContextConcatCTM(context, imageView.transform)

        CGContextTranslateCTM(context, -xCenter, -yCenter)
        
        var drawingRect : CGRect = CGRectZero
        drawingRect.size = canvasSize

        //Transaltion
        drawingRect.origin.x = (xCenter - size.width*0.5)
        drawingRect.origin.y = (yCenter - size.height*0.5)

        //Aspectfit calculation
        if boundsScale > imageScale {
            drawingRect.size.width =  drawingRect.size.height * imageScale
        }else{
            drawingRect.size.height = drawingRect.size.width / imageScale
        }
        
        image!.drawInRect(drawingRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImagePNGRepresentation(newImage)?.writeToFile("/Users/admin/Desktop/xyy.png", atomically: true)
        
        let sb = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = sb.instantiateViewControllerWithIdentifier("DetailViewController") as? DetailViewController
        vc!.image = newImage
        self.navigationController?.pushViewController(vc!, animated: true)

    }
}
