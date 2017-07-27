//
//  ViewController.swift
//  Weather
//
//  Created by yadong.ye on 2017/7/21.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

//http://www.sojson.com/open/api/weather/json.shtml?city=杭州

import UIKit

class ViewController:UIViewController, Networkable{

    @IBOutlet weak var tableView: MainTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    func refresh()  {
        getRequest(url: "http://www.sojson.com/open/api/weather/json.shtml", ["city":"杭州"]) {[weak self] json in
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
}


