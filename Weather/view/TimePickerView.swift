//
//  TimePickerView.swift
//  WeatherLife
//
//  Created by 句芒 on 2017/8/7.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit

class TimePickerView: UIPickerView ,UIPickerViewDelegate,UIPickerViewDataSource{

    var selected :((_ row1:Int?,_ row2:Int?,_ row3:Int?) -> ())?
    var rows : [Int]?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
    }
 
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 24
        }else if component == 1 {
            return 60
        }else {
            return 60
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(row) h"
        }else if component == 1 {
            return "\(row) min"
        }else if component == 2 {
            return "\(row) s"
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if rows == nil {
            rows = [0,0,0]
        }
        if (0...2).contains(component) {
            rows?[component] = row
        }
        
        guard let result = self.selected else {
            return
        }
        result(rows?[0],rows?[1],rows?[2])
    }
}
