//
//  AnimateItem.swift
//  TabBarDemo
//
//  Created by Millman YANG on 2016/12/17.
//  Copyright © 2016年 Millman YANG. All rights reserved.
//

import UIKit

public enum AnimateType {
    case scale(rate:Float)
    case jump()
    case rotation(type:RotationType)
    case shake
}

public enum ItemAnimateType {
    case content(type:AnimateType)
    case icon(type:AnimateType)
    case label(type:AnimateType)
}

class MMAnimateItem: NSObject {
    var icon:UIImageView?
    var label:UILabel?
    var animateType:ItemAnimateType = .content(type: .scale(rate: 1.2))
    var tabBarView:UIView? {
        didSet {
            self.setItem()
        }
    }
    var duration:TimeInterval = 0.3
    func setItem() {
        if let contentImageClass = NSClassFromString("UITabBarSwappableImageView"),
            let contentLabelClass = NSClassFromString("UITabBarButtonLabel") {
            
            tabBarView?.subviews.forEach({ (view) in
                if let v = view as? UIImageView , view.isKind(of: contentImageClass) {
                    icon = v
                } else if let v = view as? UILabel, view.isKind(of: contentLabelClass) {
                    label = v
                }
            })
        }
    }
    
    func animate() {
        switch animateType {
            case .content(let type):
                if let view = tabBarView {
                    self.animateItem(item: view, type: type)
                }
            case .icon(let type):
                if let i = icon {
                    self.animateItem(item: i, type: type)
                }
            case .label(let type):
                if let l = label {
                    self.animateItem(item: l, type: type)
                }
        }
    }
    
    fileprivate func animateItem(item:UIView,type:AnimateType) {
        item.animate.duration = duration
        switch type {
            case .scale(let rate):
                item.animate.scaleBounce(rate: rate)
            case .jump():
                item.animate.jumpY()
            case .rotation(let type):
                item.animate.rotation(type: type)
            case .shake:
                item.animate.shake()
        }
    }
}
