//
//  ImageAnimateLayer.swift
//  Pods
//
//  Created by Millman YANG on 2016/12/20.
//
//

import UIKit

class ImageAnimateLayer: CAShapeLayer {
    var selectImage:UIImage? {
        didSet {
            self.contents = selectImage?.cgImage
        }
    }
    
    func animate(show:Bool , duration:TimeInterval) {
        let animate = CABasicAnimation.init(keyPath: "transform.scale")
        animate.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        animate.duration = duration
        animate.fromValue = show ? 0.0 : 1.2
        animate.toValue = show ? 1.2 : 0.0
        animate.isRemovedOnCompletion = false
        animate.delegate = self
        animate.fillMode = kCAFillModeBoth
        self.mask = generateMask()
        self.mask?.add(animate, forKey: "Scale")
    }
    
    func generateMask() -> CAShapeLayer {
        let rect = self.bounds.insetBy(dx: 0, dy: 0)
        let maxValue = max(rect.width, rect.height)
        let bezier = UIBezierPath.init(ovalIn: rect)
        
        let mask = CAShapeLayer()
        mask.cornerRadius = maxValue/2
//        mask.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        mask.path = bezier.cgPath
        mask.frame = self.bounds
        mask.strokeColor = UIColor.clear.cgColor
        mask.fillColor = UIColor.red.cgColor
        mask.masksToBounds = true
        return mask
    }
}

extension ImageAnimateLayer : CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
    
    
}
