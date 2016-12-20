//
//  MMTabBarAnimateController.swift
//  Pods
//
//  Created by Millman YANG on 2016/12/17.
//
//

import UIKit

open class MMTabBarAnimateController: UITabBarController {
    var animateItems = [MMAnimateItem]()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initAnimateItem()
        self.resetBarItem()
    }
    
    override open var selectedViewController: UIViewController? {
        didSet {
            if let select = selectedViewController, let currentValue = self.viewControllers?.index(of: select) ,
                currentValue < animateItems.count {
                animateItems[currentValue].animate(isSelect: true)
              
                if let preSelect = oldValue , let preValue = self.viewControllers?.index(of: preSelect) ,
                        currentValue != preValue , preValue < animateItems.count{
                            switch animateItems[preValue].animateType {
                                case .iconExpand(_):
                                    animateItems[preValue].animate(isSelect: false)
                                default:break
                    }
                }
            }
        }
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.resetBarItem()
    }
    
    public func setAnimateAllItem(animate:ItemAnimateType,duration:TimeInterval) {
        animateItems.forEach { (item) in
            item.animateType = animate
            item.duration = duration
        }
    }
    
    public func setAnimateAllItem(animate:ItemAnimateType) {
        self.setAnimateAllItem(animate: animate, duration: 0.3)
    }
    
    public func setAnimate(index:Int,animate:ItemAnimateType,duration:TimeInterval) {
        if index < animateItems.count {
            animateItems[index].animateType = animate
            animateItems[index].duration = duration
        } else {
            print("Out of Range")
        }
    }
    
    public func setAnimate(index:Int,animate:ItemAnimateType) {
        self.setAnimate(index: index, animate: animate, duration: 0.3)
    }
    
    public func setBadgeAnimate(index:Int,animate:AnimateType) {
        if index < animateItems.count {
            animateItems[index].badgeAnimateType = animate
        } else {
            print("Out of Range")
        }
    }
    
    public func setAllBadgeAnimate(animate:AnimateType) {
        animateItems.forEach { (item) in
            item.badgeAnimateType = animate
        }
    }    
}

//Private
extension MMTabBarAnimateController {
    
    fileprivate func initAnimateItem() {
        tabBar.items?.forEach{ _ in animateItems.append(MMAnimateItem())}
    }
    
    fileprivate func resetBarItem() {
        if let classType = NSClassFromString("UITabBarButton") {

            let tabBarSubView = tabBar.subviews.flatMap({ (vi) -> UIView? in
                return vi.isKind(of: classType) ? vi : nil
            }).sorted(by: {  $0.0.frame.origin.x < $0.1.frame.origin.y })
            
            tabBarSubView.enumerated().forEach({ (idx,view) in
                animateItems[idx].item = tabBar.items?[idx]
                animateItems[idx].tabBarView = view
            })
        }
    }
}
