//
//  BaseTabBarViewController.swift
//  MMTabBarAnimation
//
//  Created by Millman YANG on 2016/12/17.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import MMTabBarAnimation
class BaseTabBarViewController: MMTabBarAnimateController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.setAnimate(index: 0, animate: .icon(type: .jump()), duration: 0.5)
        super.setAnimate(index: 1, animate: .icon(type: .rotation(type: .left)))
        super.setAnimate(index: 2, animate: .icon(type: .scale(rate: 1.2)))
        super.setAnimate(index: 3, animate: .label(type: .shake))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
