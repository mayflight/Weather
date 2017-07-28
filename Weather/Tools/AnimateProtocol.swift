//
//  AnimateProtocol.swift
//  Weather
//
//  Created by 句芒 on 2017/7/28.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import Foundation
import UIKit
protocol BezierPathAnimateable {
    /**
     贝塞尔曲线动画
     */
    func bezierAnimate(_ view:UIView,points fourpoints:[CGPoint])
}

extension BezierPathAnimateable where Self : UIView{
    func bezierAnimate(_ view:UIView,points fourpoints:[CGPoint]) {
        guard fourpoints.count <= 4 else {
            return
        }
        let bezierPath = UIBezierPath()
        bezierPath.move(to:fourpoints[0])
        bezierPath.addCurve(to: fourpoints[1], controlPoint1: fourpoints[2], controlPoint2:fourpoints[3])
        let animate = CAKeyframeAnimation(keyPath: "position")
        animate.path = bezierPath.cgPath
        animate.duration = 5
        animate.repeatCount = HUGE
        animate.rotationMode = kCAAnimationRotateAuto
        view.layer.add(animate, forKey: "Move")
    }
}

