//
//  SetViewController.swift
//  Weather
//
//  Created by 句芒 on 2017/7/31.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit

class SetViewController: UIViewController,GestureProtocol{

    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeGesture(self, action: #selector(swipe), view: self.view)
    }

    
    func swipe() {
        self.dismiss(animated: true, completion: nil)
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
