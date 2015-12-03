//
//  play.swift
//  myTest
//
//  Created by 张 on 15/12/3.
//  Copyright © 2015年 张. All rights reserved.
//

import UIKit

class play: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()

       view.backgroundColor = UIColor.yellowColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        return .LandscapeLeft
    }
}
