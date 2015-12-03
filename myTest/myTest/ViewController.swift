//
//  ViewController.swift
//  myTest
//
//  Created by 张 on 15/12/3.
//  Copyright © 2015年 张. All rights reserved.
//

import UIKit
import SnapKit
var mainBound = UIScreen.mainScreen().bounds
var HeightOfCardView = UIScreen.mainScreen().bounds.height/5 + 20
var WidthofCardView = mainBound.width - 10
var visibleCardPart = WidthofCardView/54
var CardWidth = WidthofCardView
class ViewController:UIViewController
{

    var holdView:UIView?
    var cardImage = [UIImage]()
    var imageViews = [UIImageView]()
    var status = [Int]()
    override func viewDidLoad()
    {
       showCard()
    }


    func showCard()
    {
    
     self.holdView = UIView()
        
     self.holdView?.bounds = CGRectMake(0, 0, WidthofCardView,  HeightOfCardView)
     self.holdView?.backgroundColor = UIColor.clearColor()
     self.holdView?.center = CGPointMake(mainBound.width/2, mainBound.height - (HeightOfCardView/2) )
     view.addSubview(self.holdView!)
     print(visibleCardPart)
        for item in 1 ... 32
        {
            let image = UIImage(named: "\(item)")
            self.cardImage.append(image!)
            let imageView = UIImageView(frame: CGRectMake(CGFloat(item - 1) * 13, 0, 40, HeightOfCardView - 20))
            imageView.image = image
            imageView.tag = item - 1
            imageView.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: "tapAction:")
            imageView.addGestureRecognizer(tap)
            self.holdView?.addSubview(imageView)
            self.status.append(0)
            self.imageViews.append(imageView)
        
        }
        self.holdView?.bounds.size.width = (self.holdView?.bounds.width)! - ((self.holdView?.bounds.width)! - self.imageViews[31].ImageLeftX())
    }
    func tapAction(tap:UITapGestureRecognizer)
    {
        if let imageView = tap.view as? UIImageView
        {
            if  self.status[imageView.tag] == 0
            {
                print("0")
              let  frame = imageView.frame
              UIView.animateWithDuration(0.5, animations: { () -> Void in
                imageView.frame.origin.y = frame.origin.y - 20
                self.status[imageView.tag] = 1
                }, completion: nil)
            
            
            }else if self.status[imageView.tag] == 1{
            
                    print("1")
                let  frame = imageView.frame
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    imageView.frame.origin.y = frame.origin.y + 20
                    self.status[imageView.tag] = 0
                    }, completion: nil)
                

            
            }
           
            
           
        }
        
    
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let touch = touches.count
//        for item in touches
//        {
//        
//        print(item.locationInView(self.holdView))
//        }
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.count
        for item in touches
        {
              print(item.locationInView(self.holdView))
        }
        

    }

}