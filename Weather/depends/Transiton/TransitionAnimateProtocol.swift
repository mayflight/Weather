//
//  GesturePortocol.swift
//  ControllerTransition
//
//  Created by 句芒 on 2017/6/14.
//  Copyright © 2017年 fanwei. All rights reserved.
//

import Foundation
import UIKit
protocol AnimateProtocol {
    func scaleAlpha(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning)
    func fromTop(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning)
    func toLeft(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning)
    func fromTopLeftCorner(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning)
    func rotateXZ(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning)
    func dragFromRight(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning)
    func flip(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning)
    func rightIn(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning)
    func flipOut(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning)
    var time:TimeInterval {get set}
}

extension AnimateProtocol {
    var time : TimeInterval {
        return 1
    }
    func scaleAlpha(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning) {
        
        fromView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        fromView.alpha = 0.8
        toView.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        toView.alpha = 0.1
        UIView.animate(withDuration: time, animations: {
            fromView.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
            fromView.alpha = 0.2
            toView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            toView.alpha = 0.8
        }) { (finished) in
            fromView.transform = CGAffineTransform.identity
            toView.transform = CGAffineTransform.identity
            context.completeTransition(true)
        }
    }
    
    func fromTop(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning) {
        let frame = toView.frame
        toView.frame = CGRect(x: 0, y: -frame.size.height, width: frame.size.width, height: frame.size.height)
        UIView.animate(withDuration: time, animations: {
            toView.frame = frame
        }) { (finished) in
            context.completeTransition(true)
        }
    }
    
    func toLeft(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning) {
        let frame = fromView.frame
        toView.frame = CGRect(x: frame.size.width, y: 0, width: frame.size.width, height: frame.size.height)
        UIView.animate(withDuration: time, animations: {
            fromView.frame = CGRect(x: -frame.size.width, y: 0, width: frame.size.width, height: frame.size.height)
            toView.frame = frame
        }) { (finished) in
            context.completeTransition(true)
        }
    }
    func fromTopLeftCorner(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning) {
        let frame = fromView.frame
        toView.transform = CGAffineTransform.init(translationX: -frame.size.width, y: -frame.size.height)
        UIView.animate(withDuration: time, animations: {
            toView.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }) { (finished) in
            context.completeTransition(true)
        }
        
    }
    
    func rotateXZ(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning) {
        var transform = CATransform3DMakeRotation(.pi, 1,0, 1)
        transform.m34 = -1/1000
        UIView.animate(withDuration: time, animations: {
            fromView.layer.transform = transform
        }) { (finished) in
            fromView.layer.transform = CATransform3DIdentity
            context.completeTransition(true)
        }
        
        
    }
    
    func dragFromRight(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning) {
        let frame = fromView.frame
        var transform = CATransform3DMakeTranslation(frame.size.width, 0, 10)
        transform = CATransform3DScale(transform, 1, 0.1,1)
        UIView.animate(withDuration: time, animations: {
            fromView.layer.transform = transform
        }) { (finished) in
            fromView.layer.transform = CATransform3DIdentity
            context.completeTransition(true)
        }
    }
    
    func flip(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning) {
        toView.layer.transform = CATransform3DMakeRotation(-.pi/2, 0, 1, 0)        
        UIView.animateKeyframes(withDuration: time, delay: 0, options: .layoutSubviews, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                fromView.layer.transform = CATransform3DMakeRotation(-.pi/2, 0, 1, 0)
                fromView.layer.transform.m34 = -0.001
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                toView.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0)
                toView.layer.transform.m34 = -0.001
            })
        }) { (finished) in
            fromView.layer.transform = CATransform3DIdentity
            toView.layer.transform = CATransform3DIdentity
            context.completeTransition(true)
        }
    }
    
    func rightIn(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning) {
        let frame = fromView.frame
        fromView.layer.anchorPoint = CGPoint(x:0.9, y: 0.5)
        fromView.frame = CGRect(x: frame.size.width/2, y: 0, width: frame.size.width, height: frame.size.height)
        
        UIView.animate(withDuration: time, animations: {
            var transform = CATransform3DMakeRotation(.pi/2, 0,1, 0)
            transform.m34 = -0.001
            fromView.layer.transform = transform
        }) { (finished) in
            fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            fromView.layer.transform = CATransform3DIdentity
            fromView.frame = frame
            context.completeTransition(true)
        }
    }
    
    func flipOut(_ fromView:UIView ,_ toView:UIView ,context:UIViewControllerContextTransitioning) {
       let startTransform = CATransform3DMakeTranslation(-fromView.frame.size.width/2, 0, 0)
        toView.alpha = 0.1
        UIView.animateKeyframes(withDuration: time, delay: 0, options: .layoutSubviews, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration:0.1, animations: {
                fromView.layer.transform = startTransform
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration:0.9, animations: {
                fromView.layer.transform = CATransform3DRotate(startTransform, -.pi/2, 0,1,0)
                fromView.layer.transform.m34 = -0.001
                toView.alpha = 1
            })
        }) { (finished) in
            fromView.layer.transform = CATransform3DIdentity
            context.completeTransition(true)
        }
    }
}

