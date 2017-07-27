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

extension String {
    func getDouble() -> Double {
        let result = self.characters.reduce("") {
            guard Double(String($1)) != nil else{
                return $0
            }
            return $0 + String($1)
        }
        guard let r = Double(result) else {
            return 0
        }
        return r
    }
}

extension Date {
    func monthDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: self)
    }
    func monthDay(next count:Int) -> [String] {
        var dataes = [String]()
        var index = 0
        while index <  count{
            dataes.append(Date(timeInterval: TimeInterval(3600*24*index), since: self).monthDay())
            index += 1
        }
        return dataes
    }
}

protocol Convertabel {
    func stringConvertDouble(_ string : String?) -> Double
}

extension Convertabel {
    func stringConvertDouble(_ string : String?) -> Double {
        if string == nil {
            return 0
        }
        return string!.getDouble()
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
    func getRequest(url:String,_ params:[String:String],_ callBack:@escaping (String?)->())
}
extension Networkable {
    func getRequest(url:String,_ params:[String:String],_ callBack:@escaping (String?)->()) {        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (respones) in
                if respones.result.isFailure {
                    return
                }
            
                guard let json = respones.result.value else{
                    return
                }
                callBack(json)
            
        }
    }
}
