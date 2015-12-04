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
//出牌区的宽度
var selectItemWidth = mainBound.width/4
var selectItemHeight:CGFloat = 20
var ChuPaiBtn:UIButton = UIButton()
var TipsBtn = UIButton()
var MiddleView = UIView()
//牌载体的高度
var HeightOfCardView = UIScreen.mainScreen().bounds.height/5 + 30
//牌载体的宽度
var WidthofCardView:CGFloat = mainBound.width - 10
//牌的宽度
var WidthOfCard:CGFloat = 40
//牌的露出部分
var VisiblePartOfCard:CGFloat = 13
//牌的高度
var CardHeight:CGFloat = HeightOfCardView - 30
//根据屏幕的宽度的调整 调整arry中的数据，这里为默认值
var Arry:[CGFloat] = [VisiblePartOfCard,WidthOfCard]
// 用来存储那些牌是选中的 出牌之后删去对应的布尔值
//这里为临时记录visible part 和 widthofcard
var RealArry:[CGFloat]?


class ViewController:UIViewController
{

    ///展示扑克的载体view
    var displayView:UIView?
    var activeCard = [Bool]()
    var holdView:UIView?
    var SelectItem:UIView?
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
     self.SetselectItem(self.holdView!)
    
     let tmpArry = changeCardWidth()
       RealArry = tmpArry
        for item in 1 ... 32
        {
            
            let image = UIImage(named: "\(item)")
            self.cardImage.append(image!)
            let imageView = UIImageView(frame: CGRectMake(CGFloat(item - 1) * tmpArry[0] , 20, tmpArry[1],CardHeight))
            imageView.image = image
            imageView.tag = item - 1
            imageView.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: "tapAction:")
            imageView.addGestureRecognizer(tap)
            self.holdView?.addSubview(imageView)
            self.status.append(0)
            self.imageViews.append(imageView)
            self.activeCard.append(false)
        
        }
        self.holdView?.bounds.size.width = (self.holdView?.bounds.width)! - ((self.holdView?.bounds.width)! - self.imageViews.last!.ImageLeftX())
        self.holdView?.backgroundColor = UIColor.grayColor()
    }
    
    
    func changeCardWidth() ->[CGFloat]
    {
        if (mainBound.width - ((VisiblePartOfCard * 32 + WidthOfCard - VisiblePartOfCard))) > 50
        {
            print(">50")
             Arry[0] = Arry[0] + 5
             Arry[1] = Arry[1] + 18
            return Arry
            
        }
          print("<50")
    
            return Arry
    }
    
   func addImageViewToHoldView()
   {
    
     for(var i = 0 ;i < self.imageViews.count;i++)
     {
    
    
        
    
     }
    
    
    
    
    
    
    }

    func tapAction(tap:UITapGestureRecognizer)
    {
        if let imageView = tap.view as? UIImageView
        {
            if  self.status[imageView.tag] == 0
            {
               self.activeCard[imageView.tag] = true
                
              let  frame = imageView.frame
              UIView.animateWithDuration(0.5, animations: { () -> Void in
                imageView.frame.origin.y = frame.origin.y - 15
                self.status[imageView.tag] = 1
                }, completion: nil)
            
            
            }else if self.status[imageView.tag] == 1{
            
                    print("1")
                self.activeCard[imageView.tag] = false
                let  frame = imageView.frame
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    imageView.frame.origin.y = frame.origin.y + 15
                    self.status[imageView.tag] = 0
                    }, completion: nil)
                

            
            }
           
            
           
        }
        
    
    }

    func SetselectItem(relationView:UIView)
    {
         SelectItem = UIView()
        SelectItem?.frame = CGRectMake(mainBound.width/2 - selectItemWidth/2, relationView.frame.origin.y -  (selectItemHeight + 5) , selectItemWidth, selectItemHeight)
        //出牌
         SelectItem?.backgroundColor = UIColor.clearColor()
         let frame = SelectItem?.frame
         ChuPaiBtn.frame = CGRectMake(0, 0, (frame?.width)!/4, (frame?.height)!)
        
         ChuPaiBtn.layer.cornerRadius = 2
         ChuPaiBtn.layer.borderWidth = 0.1
        
         ChuPaiBtn.setTitle("出牌", forState: UIControlState.Normal)
         ChuPaiBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
         ChuPaiBtn.setTitleColor(UIColor.clearColor(), forState: UIControlState.Highlighted)
         ChuPaiBtn.addTarget(self, action: "showCards:", forControlEvents: UIControlEvents.TouchUpInside)
         ChuPaiBtn.titleLabel?.font = UIFont.systemFontOfSize(10)
         SelectItem?.addSubview(ChuPaiBtn)
        
        //提示
        TipsBtn.frame = CGRectMake((frame?.width)! - (frame?.width)!/4 , 0, (frame?.width)!/4, (frame?.height)!)
        TipsBtn.layer.cornerRadius = 2
        TipsBtn.layer.borderWidth = 0.1
        
        TipsBtn.setTitle("提示", forState: UIControlState.Normal)
        TipsBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        TipsBtn.setTitleColor(UIColor.clearColor(), forState: UIControlState.Highlighted)
        TipsBtn.addTarget(self, action: "showTips:", forControlEvents: UIControlEvents.TouchUpInside)
        TipsBtn.titleLabel?.font = UIFont.systemFontOfSize(10)
        
        SelectItem?.addSubview(TipsBtn)
        
        //小时钟
        MiddleView.bounds = CGRectMake(0, 0, (frame?.width)!/4, (frame?.height)!)
        MiddleView.backgroundColor = UIColor.yellowColor()
        MiddleView.layer.cornerRadius = 2
        MiddleView.layer.borderWidth = 1
        
        MiddleView.center = CGPointMake((frame?.width)!/2, (frame?.height)!/2)
        SelectItem?.addSubview(MiddleView)
        
        
         view.addSubview(SelectItem!)
    

    }
    //出牌
    func showCards(btn:UIButton)
    {
        print("show Cards")
      
        var total = 0
        for var index = 0 ;index <  self.activeCard.count;index++
        {
            if activeCard[index] == true
            {
               
                total = total + 1

            
            }
        }
        if total == 0
        {
        
           print("none")
        }else{
          print(total)
        
        
        }
        
        
    }
    //提示
    
    func showTips(btn:UIButton){
    
      print("showTip")
    }
    
   //展示牌到桌面上
    func displayCardOnWindow(numofCard:Int)
    {
        
        self.displayView = nil
        self.displayView = UIView()
        
        if RealArry?.count == 0 || RealArry?.count == 1 || RealArry == nil
        {
          return
        }
        
        let TotalWidth = RealArry![0] * CGFloat(numofCard) + RealArry![0] - RealArry![1]
        
        self.displayView?.bounds = CGRectMake(0, 0, TotalWidth, WidthOfCard)
        
        for var index = 0 ; index <  activeCard.count; index++ {
        
        
        }
        
        
    
    
    
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        for item in touches
        {
              print(item.locationInView(self.holdView))
        }
        

    }

}