//
//  StruceModel.swift
//  Weather
//
//  Created by 句芒 on 2017/7/25.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import Foundation
import UIKit
import HandyJSON
struct WeatherDetail:HandyJSON {
    var date:String?
    var high:String?
    var fengli:String?
    var low:String?
    var fengxiang:String?
    var type:String?
}

struct WeatherAll:HandyJSON {
    var city:String?
    var forecast:[WeatherDetail]?
    var ganmao:String?
    var wendu:Float?
}

struct WeatherResult:HandyJSON {
    var data:WeatherAll?
    var status:Int?
    var message:String?
}
