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
class ViewController:UIViewController, Networkable{

    @IBOutlet weak var tableView: MainTableView!
    
    let manager = LocationManager()
    let animateManager = AnimateManager()
    var city : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if city != nil {
            return
        }
        manager.startLocation() { [weak self] in
            guard let city = $1.locality else {
                return
            }
            self?.city = city
            self?.refresh()
        }
    }
    
    func refresh()  {
        if city == nil {
            return
        }
        getRequest(url: "http://www.sojson.com/open/api/weather/json.shtml", ["city":"\(city!)"]) {[weak self] json in
            guard let result = WeatherResult.deserialize(from: json) else {
                return
            }
            
            if result.status != 200 {
                return
            }
            
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
    
    deinit {
        print("删除")
    }
}


