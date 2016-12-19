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
    }
    
    override open var selectedViewController: UIViewController? {
        didSet {
            
            if let select = selectedViewController,
                let value = self.viewControllers?.index(of: select) , value < animateItems.count{
                animateItems[value].animate()
            }
        }
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.findBarItems()
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
    
    fileprivate func findBarItems() {
        if let classType = NSClassFromString("UITabBarButton") {
            var idx = 0
            tabBar.subviews.forEach({ (view) in
                if view.isKind(of: classType) && animateItems.count > idx{
                    animateItems[idx].tabBarView = view
                    animateItems[idx].item = tabBar.items?[idx]
                    idx += 1
                }
            })
            
            animateItems.sort(by: { (item0, item1) -> Bool in
                if let v0 = item0.tabBarView , let v1 = item1.tabBarView {
                    return v0.frame.origin.x < v1.frame.origin.x
                }
                return false
            })
        }
    }
    
}
