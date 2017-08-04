//
//  LocalNoticationProtocol.swift
//  WeatherLife
//
//  Created by 句芒 on 2017/8/4.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import Foundation
import UIKit
protocol LocalNotificationabel {
    var application:UIApplication {get}
    func registNotification()
    func cancleBadge()
    func sendNotification(title:String,body:String,time:Date)
}

extension LocalNotificationabel {
    var application:UIApplication {
        return UIApplication.shared
    }
    
    func registNotification() {
        application.registerUserNotificationSettings(UIUserNotificationSettings.init(types: [.alert,.sound,.badge], categories: nil))
    }
    
    func cancleBadge() {
        application.applicationIconBadgeNumber = 0
    }
    
    func sendNotification(title:String,body:String,time:Date) {
        application.cancelAllLocalNotifications()
        
        let localNotifiction = UILocalNotification()
        localNotifiction.fireDate = time
        localNotifiction.timeZone = NSTimeZone.system
        localNotifiction.alertBody = body
        localNotifiction.alertTitle = title
        localNotifiction.applicationIconBadgeNumber = 1
        localNotifiction.soundName = "noti.m4a"
        localNotifiction.repeatInterval = .day
        //添加推送
        application.scheduleLocalNotification(localNotifiction)
    }
}
