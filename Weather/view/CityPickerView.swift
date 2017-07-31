//
//  CityPickerView.swift
//  Weather
//
//  Created by 句芒 on 2017/7/31.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit

class CityPickerView: UIPickerView,UIPickerViewDelegate,UIPickerViewDataSource{

    var citys : Array<Dictionary<String, Any>>?
    var selectedRow = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
        guard let path = Bundle.main.path(forResource: "city", ofType: "plist") else {
            return
        }
        
        let cityArray = NSArray(contentsOfFile: path)
        citys = cityArray as? Array<Dictionary<String, Any>>
        
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        guard  let count = citys?.count else{
            return 0
        }
        
        guard let cityDictory = citys?[selectedRow],let cityArray = cityDictory["cities"] as? [String] else {
            return 0
        }
        
        if component == 0 {
            return count
        }else {
            return cityArray.count
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        guard let cityDictory = citys?[selectedRow],let cityArray = cityDictory["cities"] as? [String] else {
            return nil
        }
        
        if component == 0 {
            return citys?[row]["state"] as? String
        }
        
        if component == 1{
            return cityArray[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedRow = row
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.reloadComponent(1)
        }
        
    }
    
    
}
