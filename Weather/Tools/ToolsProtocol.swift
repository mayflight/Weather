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
    func monthDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: self)
    }
    /**
     获取接下来n天的月/日 
     */
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
