//
//  AnimateProtocol.swift
//  Weather
//
//  Created by 句芒 on 2017/7/25.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
protocol Sizeable {
    var width:CGFloat {get}
    var height:CGFloat {get}
}

extension Sizeable where Self:UIView {
    var width:CGFloat {
        return  self.frame.size.width
    }
    var height:CGFloat {
        return self.frame.size.height
    }
}

protocol BezierPathAnimateable {
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

protocol Networkable {
    func getRequest(url:String,_ params:[String:String],_ callBack:@escaping (JSON)->())
}
extension Networkable {
    func getRequest(url:String,_ params:[String:String],_ callBack:@escaping (JSON)->()) {
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (respones) in
            
            guard let json = respones.result.value else{
                return
            }
            let jsonData = JSON(json)
            callBack(jsonData)
        }
    }
}
