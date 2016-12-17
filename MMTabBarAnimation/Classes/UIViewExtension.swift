//
//  UIViewExtension.swift
//  TabBarDemo
//
//  Created by Millman YANG on 2016/12/17.
//  Copyright © 2016年 Millman YANG. All rights reserved.
//

import UIKit

public enum RotationType {
    case left
    case right
}

public struct TabBarAnimate {
    internal let view: UIView
    var duration:TimeInterval = 0.3
    
    public func scaleBounce(rate:Float) {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.duration = duration
        animation.values = [1.0,rate,1.1,0.8,1.0]
        self.view.layer.add(animation, forKey: "Scale")
    }
    
    public func rotation(type:RotationType) {
        let option:UIViewAnimationOptions = (type == .left) ? .transitionFlipFromLeft : .transitionFlipFromRight
        UIView.transition(with: self.view, duration: duration, options: option, animations: nil, completion: nil)
    }
    
    func shake() {
        let animation = CAKeyframeAnimation.init(keyPath: "position.x")
        let x = self.view.center.x
        animation.values = [(x-3),(x+3),(x-2),(x+2),(x-1),(x+1),(x)]
        animation.duration = duration
        self.view.layer.add(animation, forKey: "Shake")
    }
    
    func jumpY() {
        let animation = CAKeyframeAnimation.init(keyPath: "position.y")
        let y = self.view.center.y
        animation.values = [(y-5),(y),(y-3),(y),(y-1),(y)]
        animation.duration = duration
        self.view.layer.add(animation, forKey: "JumpY")
    }
    
    internal init(view: UIView) {
        self.view = view
    }
}

private var animateKey = "TabBarAnimateKey"
extension UIView {
    public var animate: TabBarAnimate {
        set {
            objc_setAssociatedObject(self, &animateKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        } get {
            if let animate = objc_getAssociatedObject(self, &animateKey) as? TabBarAnimate {
                return animate
            } else {
                self.animate = TabBarAnimate(view: self)
                return self.animate
            }
        }
    }
}
