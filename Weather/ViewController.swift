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
        getRequest(url: "http://www.sojson.com/open/api/weather/json.shtml", ["city":"杭州"]) { json in
            if json["status"].int != 200 {
                return
            }
            guard let descript = json["data"]["ganmao"].string else{
                return
            }
            guard let tem = json["data"]["wendu"].string else{
                return
            }
            print("描述:\(descript),文档:\(tem)")
        }
    }
    
  
    
}
