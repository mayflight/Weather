//
//  AnimateManager.swift
//  ControllerTransition
//
//  Created by 句芒 on 2017/6/14.
//  Copyright © 2017年 fanwei. All rights reserved.
//

import Foundation
import UIKit

enum TransitionAnimateType:Int {
    case scaleAlpha = 0
    case fromTop
    case toLeft
    case fromTopLeftCorner
    case rotateXZ
    case dragFromRight
    case flip
    case rightIn
    case flipOut
}

class AnimateManager:NSObject,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate,AnimateProtocol,UINavigationControllerDelegate{
    var time:TimeInterval = 1
    var animateType = TransitionAnimateType.scaleAlpha
    var color = UIColor.white
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return time
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let view = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        if fromView == nil || toView == nil {
            return
        }
        view.backgroundColor = color
        view.addSubview(fromView!)
        view.addSubview(toView!)
        switch animateType {
        case .scaleAlpha:
            scaleAlpha(fromView!, toView!, context: transitionContext)
        case .fromTop:
            fromTop(fromView!, toView!, context: transitionContext)
        case .toLeft:
            toLeft(fromView!, toView!, context: transitionContext)
        case .fromTopLeftCorner:
            fromTopLeftCorner(fromView!, toView!, context: transitionContext)
        case .rotateXZ:
            rotateXZ(fromView!, toView!, context: transitionContext)
        case .dragFromRight:
            dragFromRight(fromView!, toView!, context: transitionContext)
        case .flip:
            flip(fromView!, toView!, context: transitionContext)
        case .rightIn:
            rightIn(fromView!, toView!, context: transitionContext)
        case .flipOut:
            flipOut(fromView!, toView!, context: transitionContext)
        }
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}
