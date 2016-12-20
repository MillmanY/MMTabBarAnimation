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
    case jump
    case rotation(type:RotationType)
    case shake
    case none
}

public enum ItemAnimateType {
    case content(type:AnimateType)
    case icon(type:AnimateType)
    case label(type:AnimateType)
    case iconExpand(image:UIImage)
}

class MMAnimateItem: NSObject {
    
    var label:UILabel?
    var badgeAnimateType:AnimateType = .none
    var animateType:ItemAnimateType = .content(type: .none)
    var duration:TimeInterval = 0.3
    var badge:UIView?
    
    var imgAnimateLayer:ImageAnimateLayer = {
        let layer = ImageAnimateLayer()
        return layer
    }()
    
    var item:UITabBarItem? {
        didSet {
            self.observerBadge()
        }
    }
    
    var icon:UIImageView? {
        didSet {
            if let i = icon {
                imgAnimateLayer.frame = i.bounds
            }
        }
    }
    
    var tabBarView:UIView? {
        didSet {
            self.setItem()
        }
    }
    
    fileprivate func setItem() {
        if let contentImageClass = NSClassFromString("UITabBarSwappableImageView"),
            let contentLabelClass = NSClassFromString("UITabBarButtonLabel") {
            
            tabBarView?.subviews.forEach({ (view) in
                if let v = view as? UIImageView , view.isKind(of: contentImageClass) {
                    icon = v
                    icon?.layer.addSublayer(imgAnimateLayer)
                } else if let v = view as? UILabel, view.isKind(of: contentLabelClass) {
                    label = v
                } else if let _ = NSClassFromString("_UIBadgeView") {
                    badge = view
                }
            })
        }
    }
    
    fileprivate func observerBadge() {
        if let barItem = self.item , barItem.observationInfo == nil{
            barItem.addObserver(self, forKeyPath: "badgeValue", options: .new, context: nil)
        }
    }
    
    func animateBadge(type:AnimateType) {
        var delay = 0.0
        if badge == nil {
            self.setItem()
            delay = 0.1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if let badge = self.badge {
                self.animateItem(item: badge, type: type)
            }
        }
    }

    func animate(isSelect:Bool) {
        self.imgAnimateLayer.selectImage = nil
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
            case .iconExpand(let image):
                self.imgAnimateLayer.selectImage = image
                self.imgAnimateLayer.animate(show: isSelect, duration: duration)
                break
        }
    }
    
    fileprivate func animateItem(item:UIView,type:AnimateType) {
        item.animate.duration = duration
        switch type {
            case .scale(let rate):
                item.animate.scaleBounce(rate: rate)
            case .jump:
                item.animate.jumpY()
            case .rotation(let type):
                item.animate.rotation(type: type)
            case .shake:
                item.animate.shake()
            case .none:
                break
        }
    }
}

extension MMAnimateItem {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "badgeValue" {
            self.animateBadge(type: badgeAnimateType)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
