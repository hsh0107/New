//
//  Ext.swift
//  myTest
//
//  Created by 张 on 15/12/3.
//  Copyright © 2015年 张. All rights reserved.
//

import Foundation
import UIKit
extension UIView
{
    func ImageLeftX() ->CGFloat
    {
    
      let x = self.frame.origin.x + self.frame.width
    return x
    }
    
    func ImageCenterY() ->CGFloat
    {
    
       let y = self.frame.origin.y
       let CenterY = y + self.bounds.height/2
        
        return CenterY
    
     }
    
    
}