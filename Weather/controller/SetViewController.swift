//
//  SetViewController.swift
//  Weather
//
//  Created by 句芒 on 2017/7/31.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit

class SetViewController: UIViewController,GestureProtocol,LocalNotificationabel{
   
    @IBOutlet weak var cityPicker: CityPickerView!
    
    @IBOutlet weak var selectedCity: UILabel!
    
    @IBOutlet weak var noticeTime: UILabel!
    
    @IBOutlet weak var timePicker: TimePickerView!
    
    var times:[Int]?
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeGesture(self, action: #selector(swipe), view: self.view)
        cityPicker.selectedAction = {[weak self] (text:String?,row1:Int,row2:Int) ->() in
            if text != nil {
                self?.selectedCity.text = "选择城市:\(text!)"
            }
        }
        
        timePicker.selected = { [weak self] in
            self?.times = [$0 ?? 0,$1 ?? 0,$2 ?? 0]
            self?.noticeTime.text = "推送时间:\($0 ?? 0)h/\($1 ?? 0)min/\($2 ?? 0)s"
            
        }
    }
    
    func swipe() {
        self.dismiss(animated: true){[weak self] in
            guard  let controller = UIApplication.shared.keyWindow?.rootViewController as? ViewController else {
                return
            }
            guard let city = self?.cityPicker.selectedCity else {
                return
            }
            controller.refresh(city)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let rows = self.times,let date = Date().getDateBy(rows[0], rows[1], rows[2]) else {
            return
        }
        sendNotification(title: "天气播报", body:"关注天气，健康生活", time: date)
    }
}
