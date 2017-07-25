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
        self.register(UINib.init(nibName: "TemperatureCell", bundle: nil), forCellReuseIdentifier: CellIdentify.tempearture.rawValue)
        self.register(UINib.init(nibName: "ChartCell", bundle: nil), forCellReuseIdentifier: CellIdentify.chartCell.rawValue)
        self.register(UINib.init(nibName: "WindCell", bundle: nil), forCellReuseIdentifier: CellIdentify.windCell.rawValue)
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
        if indexPath.row == 0 {
            guard  let cell =  tableView.dequeueReusableCell(withIdentifier: CellIdentify.tempearture.rawValue) as? TemperatureCell else {
                return UITableViewCell()
                
            }
            return cell;
        }else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentify.chartCell.rawValue) as? ChartCell else {
                return UITableViewCell()
            }
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentify.windCell.rawValue) else {
                return UITableViewCell()
            }
            return cell;
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row != 2 {
            return
        }
        guard let windCell = cell as? WindCell else {
            return
        }
        windCell.animate()
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
