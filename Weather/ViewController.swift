//
//  ViewController.swift
//  Weather
//
//  Created by yadong.ye on 2017/7/21.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

//http://www.sojson.com/open/api/weather/json.shtml?city=杭州

import UIKit
import CoreLocation
class ViewController:UIViewController,Networkable,Saveabel,LocalNotificationabel{
    
    static let citykey = "selectedcity"
    
    @IBOutlet weak var tableView: MainTableView!
    
    let animateManager = AnimateManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = getOnDisk(ViewController.citykey) else {
            refresh()
            return
        }
        refresh(city)
        
        guard let date = Date().getDateBy(7,20, 0) else {
            return
        }
        sendNotification(title: "天气播报", body: "关注天气，健康生活。", time: date)
    }
    

    func refresh(_ city:String = "北京")  {
        getRequest(url: "http://www.sojson.com/open/api/weather/json.shtml", ["city":"\(city)"]) {[weak self] json in
            guard let result = WeatherResult.deserialize(from: json) else {
                return
            }
            
            if result.status != 200 {
                return
            }
            self?.saveOnDisk(ViewController.citykey, city)
            self?.tableView.descript = result.data?.ganmao
            self?.tableView.city = result.data?.city
            self?.tableView.weather = result.data?.forecast?.first?.type
            self?.tableView.date = result.data?.forecast?.first?.date
            self?.tableView.temperature = result.data?.wendu
            self?.tableView.weatherDetails = result.data?.forecast
            self?.tableView.reloadData()
        }
    }
    
    func transiton()  {
        guard  let controller = UIStoryboard(name: "Set", bundle: nil).instantiateInitialViewController() else {
            return
        }
        animateManager.animateType = .flip
        animateManager.color = UIColor(colorLiteralRed: 219/255.0, green: 255/255.0, blue: 213/255.0, alpha: 1)
        controller.transitioningDelegate = animateManager
        self.present(controller, animated: true, completion: nil)
    }

}


