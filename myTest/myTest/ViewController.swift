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
var selectItemHeight:CGFloat = 10
var ChuPaiBtn:UIButton = UIButton()
var TipsBtn = UIButton()
var MiddleView = UIView()
//牌载体的高度
var HeightOfCardView = UIScreen.mainScreen().bounds.height/5
//牌载体的宽度
var WidthofCardView:CGFloat = mainBound.width - 10
//牌的宽度
var WidthOfCard:CGFloat = 30
//牌的露出部分
var VisiblePartOfCard:CGFloat = 13
//牌的高度
var CardHeight:CGFloat = HeightOfCardView - 20
//根据屏幕的宽度的调整 调整arry中的数据，这里为默认值
var Arry:[CGFloat] = [VisiblePartOfCard,WidthOfCard]

//这里为临时记录visible part 和 widthofcard
var RealArry:[CGFloat]?

//记录那些牌是已经激活的并且是可以出出来的
var ActiveCard = [UIImageView]()
//用来记录玩家手里有哪些牌 默认值是空的
 var imageViews = [UIImageView]()
//用户头像的默认的宽高
let UserDefaultLogoWidth:CGFloat = 30
let UserDefaultLogoHeight:CGFloat = 30
//用户个人信心默认的宽高
let UserDefaultInfoLabelWidth:CGFloat = 80
let UserDefaultInfoLabelHeight:CGFloat = 15
enum position
{

 case left,right


}

class ViewController:UIViewController
{

    ///展示扑克的载体view
    var displayView:UIView?
   
    var holdView:UIView?
    var SelectItem:UIView?
    var cardImage = [UIImage]()
   
    var status = [Int]()
    //用户左边部分
    var leftUserImage = UIImageView()
    var leftUserLabel = UILabel()
    var leftUserPart = UIView()
    //用户右边部分
    var rightUserImage = UIImageView()
    var rightUserLabel = UILabel()
    var rightUserPart = UIView()
    //左右两用户中间打牌的载体VIEW
    var middleView:UIView = UIView()
    //用户出牌后 显示牌的载体分别是左边和右边 注意：最上面的用户不需要载体 采用和最下面的方式一样的方式显示即可
    var leftUserCardsCarrier:UIView?
    var rightUserCardsCarrier:UIView?
    
    override func viewDidLoad()
    {
       showCard()
       addMiddleView()
    }

    func addMiddleView(){
    
        
        if RealArry?.count != nil
        {
        
               self.middleView.bounds =  CGRectMake(0, 0, mainBound.width, CardHeight)
               self.middleView.center = view.center
              // self.middleView.backgroundColor = UIColor.redColor()
               view.addSubview(self.middleView)
           
           customRightOrLeftUserLayOut(.left,label:self.leftUserLabel,partView:self.middleView,image:self.leftUserImage)
           customRightOrLeftUserLayOut(.right,label:self.rightUserLabel,partView:self.middleView,image:self.rightUserImage)
        }
    
    }
    func showCard()
    {
    
     self.holdView = UIView()
     self.holdView?.bounds = CGRectMake(0, 0, WidthofCardView,  HeightOfCardView)
     self.holdView?.backgroundColor = UIColor.clearColor()
     self.holdView?.center = CGPointMake(mainBound.width/2, mainBound.height - (HeightOfCardView/2) )
     self.holdView?.backgroundColor = UIColor.redColor()
     view.addSubview(self.holdView!)
     self.SetselectItem(self.holdView!)
     addImageViewToHoldView()
    
    }
    
    
    //这里做一个测试显示牌的位置及其数量对当前VIEW的影响
    func jsutForTest(po:position)
    {
    
        let num:UInt32 = 8
        let arcNum =  Int(arc4random_uniform(num)) + 1
        
        let totalWidths = totoalWidth(arcNum)
        
        switch po
        {
            
            case .left:
                if leftUserCardsCarrier != nil
                {
                    for vw in (leftUserCardsCarrier?.subviews)!
                    {
                         vw.removeFromSuperview()
                    }
                    
                     self.leftUserCardsCarrier?.bounds.size.width = totalWidths
                    for var index:Int = 0 ; index < arcNum;index++
                    {
                    let imagev  = UIImageView(frame: CGRectMake(CGFloat(index) * RealArry![0], 0, RealArry![1], CardHeight))
                    imagev.image = UIImage(named: "\(index)")
                    leftUserCardsCarrier?.addSubview(imagev)

                    }
                self.leftUserCardsCarrier?.frame = CGRectMake(0, 0, totalWidths, CardHeight)
                self.middleView.addSubview(leftUserCardsCarrier!)
            
                }else{
                   
                   leftUserCardsCarrier = UIView(frame: CGRectZero)
                    self.leftUserCardsCarrier?.bounds.size.width = totalWidths
                    for var index:Int = 0 ; index < arcNum;index++
                    {
                        let imagev  = UIImageView(frame: CGRectMake(CGFloat(index) * RealArry![0], 0, RealArry![1], CardHeight))
                        imagev.image = UIImage(named: "\(index)")
                        leftUserCardsCarrier?.addSubview(imagev)
                        
                    }
                    self.leftUserCardsCarrier?.frame = CGRectMake(0, 0, totalWidths, CardHeight)
                    self.middleView.addSubview(leftUserCardsCarrier!)
                    

                  
            
            
            
            
                    }
            
            
            
            
            
            case .right:
            
                if rightUserCardsCarrier != nil
                {
                    for vw in (rightUserCardsCarrier?.subviews)!
                    {
                        vw.removeFromSuperview()
                    }
                    
                    self.rightUserCardsCarrier?.bounds.size.width = totalWidths
                    for var index:Int = 0 ; index < arcNum;index++
                    {
                        let imagev  = UIImageView(frame: CGRectMake(CGFloat(index) * RealArry![0], 0, RealArry![1], CardHeight))
                        imagev.image = UIImage(named: "\(index)")
                        rightUserCardsCarrier?.addSubview(imagev)
                        
                    }
                    self.rightUserCardsCarrier?.frame = CGRectMake(mainBound.width - totalWidths, 0, totalWidths, CardHeight)
                    self.middleView.addSubview(rightUserCardsCarrier!)
                    
                }else{
                    
                    rightUserCardsCarrier = UIView(frame: CGRectZero)
                    self.rightUserCardsCarrier?.bounds.size.width = totalWidths
                    for var index:Int = 0 ; index < arcNum;index++
                    {
                        let imagev  = UIImageView(frame: CGRectMake(CGFloat(index) * RealArry![0], 0, RealArry![1], CardHeight))
                        imagev.image = UIImage(named: "\(index)")
                        rightUserCardsCarrier?.addSubview(imagev)
                        
                    }
                    self.rightUserCardsCarrier?.frame = CGRectMake(mainBound.width - totalWidths - 10, 0, totalWidths, CardHeight)
                    self.middleView.addSubview(rightUserCardsCarrier!)
                    
                    
                    
                    
                    
                    
                    
            }
        
        
        
        
        }
        
    
    }
    
    func customRightOrLeftUserLayOut(po:position,label:UILabel,partView:UIView,image:UIImageView){
    
        switch po
        {
        
        case .left:
            // 这里30为默认的test高度 正式版要改成全局的变量
            self.leftUserImage.frame = CGRectMake(5 , (partView.frame.origin.y) - 35 , 30, 30)
            self.leftUserImage.image = UIImage(named: "gates")
            view.addSubview(self.leftUserImage)
            // 这里60，15为默认的test高度 正式版要改成全局的变量
            self.leftUserLabel.frame =  CGRectMake(self.leftUserImage.ImageLeftX() + 2,self.leftUserImage.frame.origin.y , 30, 30)
            self.leftUserLabel.text = "bill gates\("\n")等级:8\("\n")金币:118"
            self.leftUserLabel.numberOfLines = 0
            self.leftUserLabel.font = UIFont.systemFontOfSize(6)
            self.leftUserLabel.textColor = UIColor.blackColor()
            self.leftUserLabel.textAlignment = .Left
        view.addSubview(self.leftUserLabel)

        case.right:

             self.rightUserImage.frame = CGRectMake(mainBound.width - (UserDefaultLogoWidth + 5) , (partView.frame.origin.y) - (UserDefaultLogoWidth + 5) , UserDefaultLogoWidth, UserDefaultLogoHeight)
             self.rightUserImage.image = UIImage(named: "mask")
             view.addSubview(self.rightUserImage)
             self.rightUserLabel.frame =  CGRectMake(self.rightUserImage.frame.origin.x  - (UserDefaultLogoWidth + 2),self.rightUserImage.frame.origin.y , UserDefaultLogoWidth, UserDefaultLogoHeight)
             self.rightUserLabel.text = "elon musk \("\n")等级:8\("\n")金币:118"
             self.rightUserLabel.numberOfLines = 0
             self.rightUserLabel.font = UIFont.systemFontOfSize(6)
             self.rightUserLabel.textColor = UIColor.blackColor()
             self.rightUserLabel.textAlignment = .Right
             view.addSubview(self.rightUserLabel)
            
            
            
        
        }

    }
    
   func changeCardWidth() ->[CGFloat]
    {
        if (mainBound.width - ((VisiblePartOfCard * 32 + WidthOfCard - VisiblePartOfCard))) > 160 && (mainBound.width - ((VisiblePartOfCard * 32 + WidthOfCard - VisiblePartOfCard))) < 290
        {
            print(">160 <290")
            print(mainBound.width - ((VisiblePartOfCard * 32 + WidthOfCard - VisiblePartOfCard)))
             Arry[0] = Arry[0] + 5
            
            return Arry
            
        }else if (mainBound.width - ((VisiblePartOfCard * 32 + WidthOfCard - VisiblePartOfCard))) > 290 {
        
            print(">290")
            Arry[0] = Arry[0] + 5
           Arry[1] = Arry[1] + 12
            return Arry
        
        
        }
          print("<50")
    
            return Arry
    }
    
    //根据牌的数量 返回一个合适的宽度
    func totoalWidth(num:Int) ->CGFloat
    {
        if RealArry == nil
        {
            return CGFloat(num) * VisiblePartOfCard + WidthOfCard - VisiblePartOfCard
        }
       
         return CGFloat(num) * RealArry![0] + RealArry![1] - RealArry![0]
        
    }
    
    
    //把放牌的imageVIEW加到载体上
   func addImageViewToHoldView()
   {
    //根据屏幕的宽度动态计算纸牌的宽度
    let tmpArry = changeCardWidth()
       RealArry = tmpArry
    for item in 1 ... 32
    {
        
        let image = UIImage(named: "\(item)")
        self.cardImage.append(image!)
        let imageView = UIImageView(frame: CGRectMake(CGFloat(item - 1) * tmpArry[0] , 15, tmpArry[1],CardHeight))
        imageView.image = image
        imageView.tag = item - 1
        imageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "tapAction:")
        imageView.addGestureRecognizer(tap)
        self.holdView?.addSubview(imageView)
        self.status.append(0)
        //把当前的用户持有的纸牌载体加到imageviews中
        imageViews.append(imageView)
        
        
        
    }
    self.holdView?.bounds.size.width = (self.holdView?.bounds.width)! - ((self.holdView?.bounds.width)! - imageViews.last!.ImageLeftX())
    
  
    
    }
    
    //根据已经出的牌动态改变holdView的宽度
    func changeHoldViewWidth()
    {
        
        
        
        
        if imageViews.count != 0
        {
            for item in imageViews
            {
            
                item.removeFromSuperview()
            
            
            }
            if RealArry?.count == 0
            {
            
            return
            }
            
            self.holdView?.bounds.size.width =  CGFloat(imageViews.count) * RealArry![0] + RealArry![1] - RealArry![0]
            for var index = 0;index < imageViews.count;index++
            {
            let tmp = imageViews[index]
            tmp.frame.origin.x = CGFloat(index) * RealArry![0]
                self.holdView?.addSubview(tmp)
            
            }
        
        }
    
    
    
    }

    func tapAction(tap:UITapGestureRecognizer)
    {
        if let imageView = tap.view as? UIImageView
        {
            if  self.status[imageView.tag] == 0
            {
               
                
                //把激活的牌放到全局数组中
                ActiveCard.append(imageView)
                print("success add")
               let  frame = imageView.frame
               UIView.animateWithDuration(0.5, animations: { () -> Void in
                imageView.frame.origin.y = frame.origin.y - 10
                self.status[imageView.tag] = 1
                }, completion: nil)
            
            }else if self.status[imageView.tag] == 1{
            
                    print("1")
                //把激活状态的牌关闭
                if ActiveCard.count != 0
                {
                    for var index = 0 ;index < ActiveCard.count;index++
                    {
                        if ActiveCard[index].tag == imageView.tag
                        {
                            
                            ActiveCard.removeAtIndex(index)
                            print("removed success")
                            
                        }
                        
                    }

                }
                let  frame = imageView.frame
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    imageView.frame.origin.y = frame.origin.y + 10
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
      
        if ActiveCard.count != 0
        {
        
        
          displayCardOnWindow(ActiveCard.count)
            jsutForTest(.left)
            jsutForTest(.right)
        
        }else
        {
        
        
             print("没有牌可出了")
        }
        
    }
    //提示
    
    func showTips(btn:UIButton)
    {
    
      print("showTip")
    }
    
   //展示牌到桌面上
    func displayCardOnWindow(numofCard:Int)
    {
        
        if displayView != nil
        {
            for vw in (displayView!.subviews)
            {
                 vw.removeFromSuperview()
            
            }
            self.displayView = nil
            
        
        }
        
        self.displayView = UIView()
        
        if RealArry?.count == 0 || RealArry?.count == 1 || RealArry == nil
        {
          return
        }
        
        let TotalWidth = RealArry![0] * CGFloat(numofCard) + RealArry![1] - RealArry![0]
        
        //计算展示VIEW的宽度
        self.displayView?.bounds = CGRectMake(0, 0, TotalWidth,CardHeight )
        for var index = 0 ;index < ActiveCard.count;index++
        {
              let tmp = ActiveCard[index]
               tmp.frame = CGRectMake(CGFloat(index) * RealArry![0], 0, RealArry![1],CardHeight )
               displayView?.addSubview(tmp)
             //关闭牌的上下滚动的功能
              tmp.userInteractionEnabled = false
            //把 tmp 从imageviews中移除
            for var index = 0 ; index <  imageViews.count;index++
            {
            
                if tmp.tag == imageViews[index].tag
                {
                
                      imageViews.removeAtIndex(index)
                
                
                }
            
            }

        }
       displayView?.center = CGPointMake(mainBound.width/2,  SelectItem!.frame.origin.y - (displayView!.bounds.height/2 + 5))
        ActiveCard.removeAll(keepCapacity: false)
       view.addSubview(displayView!)
        
         //在这里调用
        changeHoldViewWidth()
    }
    
  
}