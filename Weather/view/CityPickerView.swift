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
    var selectedCity:String?
    var selectedAction:((_ text:String?,_ row1:Int,_ row2:Int) -> ())?
    let manager = LocationManager()
    
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
            return
        }
        
        if component != 1 {
            return
        }
        
        guard let cityDictory = citys?[selectedRow],let cityArray = cityDictory["cities"] as? [String] else {
            return
        }
        
        selectedCity = cityArray[row]
        let row1 = pickerView.selectedRow(inComponent: 0)
        let row2 = pickerView.selectedRow(inComponent: 1)
        
        if self.selectedAction != nil{
            self.selectedAction!(selectedCity,row1,row2)
        }
        
        if row1 == 0 && row2 == 0 {
            guard let controller = self.getController() else {
                return
            }
            manager.startLocation(controller) { [weak self] in
                guard let city = $1.locality else {
                    return
                }
                self?.selectedCity = city
                if self?.selectedAction != nil {
                    self?.selectedAction!(self?.selectedCity,row1,row2)
                }
            }
        }
    }
    
}
