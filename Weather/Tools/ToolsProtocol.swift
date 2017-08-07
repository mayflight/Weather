//
//  AnimateProtocol.swift
//  Weather
//
//  Created by 句芒 on 2017/7/25.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import Foundation
import UIKit

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

protocol Saveabel {
    func saveOnDisk(_ key:String,_ value:String)
    func getOnDisk(_ key:String) -> String?
}

extension Saveabel {
    func saveOnDisk(_ key:String,_ value:String) {
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getOnDisk(_ key:String) -> String?{
        return UserDefaults.standard.string(forKey: key)
    }
}

extension String {
    /**
     获取字符串里面包含的数字
     */
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
    
    func convertDateFormater(_ oldFormatter:String = "YYYYMMdd",new newFormatter:String = "MM月dd日") ->String {
        let formatter = DateFormatter()
        formatter.dateFormat = oldFormatter
        guard let date = formatter.date(from: self) else {
            return "errorTime"
        }
        let newTime = date.monthDay(newFormatter)
        return newTime
    }
}

protocol Convertabel {
    func stringConvertDouble(_ string : String?) -> Double
}

extension Convertabel {
    /**
     将字符串转成数字
     */
    func stringConvertDouble(_ string : String?) -> Double {
        if string == nil {
            return 0
        }
        return string!.getDouble()
    }
}

extension Date {
    /**
     将日期转成月/日 MM/dd
     */
    func monthDay(_ format:String = "MM/dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    /**
     获取接下来n天的月/日 
     */
    func monthDay(next count:Int,_ format:String = "MM/dd") -> [String] {
        var dataes = [String]()
        var index = 0
        while index <  count{
            dataes.append(Date(timeInterval: TimeInterval(3600*24*index), since: self).monthDay(format))
            index += 1
        }
        return dataes
    }
    
    /**
     将每日的时分秒转换成Date
     */
    func getDateBy(_ h:Int,_ m:Int,_ s:Int) -> Date? {
        let targetTime = h*60*60+m*60+s
        if targetTime > 24*60*60 {
            return nil
        }
        let currentdate = self.monthDay("HH,mm,ss").components(separatedBy: ",").map(){
            return Int($0)
        }
        let currentTime = currentdate.enumerated().reduce(0) {
            var result = $0
            if $1.element == nil {
                return result
            }
            if $1.offset == 0 {
                result += $1.element!*60*60
            }else if $1.offset == 1 {
                result += $1.element!*60
            }else if $1.offset == 2 {
                result += $1.element!
            }
            return result
        }
        if targetTime >= currentTime {
            return Date(timeInterval: TimeInterval(targetTime-currentTime), since: self)
        }else {
            return Date(timeInterval: TimeInterval(targetTime+24*60*60-currentTime), since: self)
        }
    }
}

extension UIViewController {
    func alert(_ message:String?,leftTitle:String = "取消",rightTitle:String, selectedAction:(()->())?)  {
        let controller = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let leftAction = UIAlertAction(title: leftTitle, style: .cancel, handler: nil)
        
        let rightAction = UIAlertAction(title: rightTitle, style: .default) { (action) in
            if selectedAction != nil {
                selectedAction!()
            }
        }
        controller.addAction(leftAction)
        controller.addAction(rightAction)
        self.present(controller, animated: true, completion: nil)
        
    }
}

extension UIView {
    func getController() -> UIViewController? {
        guard var responder = self.next else {
            return nil
        }
        
        repeat {
            if responder is UIViewController {
                return responder as? UIViewController
            }
            guard  let r = responder.next else {
                return nil
            }
            responder = r
        }while true
    }
    
    func layerBack()  {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.backgroundColor = UIColor(white: 0.3, alpha: 0.7).cgColor
    }
}
