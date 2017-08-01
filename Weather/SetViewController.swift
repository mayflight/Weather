//
//  SetViewController.swift
//  Weather
//
//  Created by 句芒 on 2017/7/31.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit

class SetViewController: UIViewController,GestureProtocol{
   
    @IBOutlet weak var cityPicker: CityPickerView!
    
    @IBOutlet weak var selectedCity: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeGesture(self, action: #selector(swipe), view: self.view)
        cityPicker.selectedAction = {[weak self] (text:String?,row1:Int,row2:Int) ->() in
            if text != nil {
                self?.selectedCity.text = "选择城市:\(text!)"
            }
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
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
