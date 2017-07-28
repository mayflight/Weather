//
//  RefreshManager.swift
//  Weather
//
//  Created by 句芒 on 2017/7/28.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit

typealias RefreshAction = () -> ()

class RefreshManager: NSObject {
    
    static private var action : RefreshAction?
    
    static func refresh(_ tabelView:UITableView,color:UIColor = UIColor.clear,tintColor:UIColor = UIColor.white,action:@escaping RefreshAction) {
        let refresh = UIRefreshControl()
        refresh.backgroundColor = color
        refresh.tintAdjustmentMode = .automatic
        refresh.tintColor = tintColor
        refresh.addTarget(self, action:#selector(refreshAction), for: UIControlEvents.valueChanged)
        tabelView.addSubview(refresh)
        self.action = action
    }
    
    static func refreshAction(_ refresh:UIRefreshControl) {
        refresh.endRefreshing()
        if self.action != nil {
            self.action!()
        }
    }
    
}
