//
//  MainTableView.swift
//  Weather
//
//  Created by 句芒 on 2017/7/21.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit

class MainTableView:UITableView,UITableViewDataSource,UITableViewDelegate{

    override func awakeFromNib() {
        self.delegate = self;
        self.dataSource = self;
    }
    
  
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)?.last as? UIView else {
            return UIView()
        }
        return headerView
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

   
}
