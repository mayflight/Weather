//
//  ChartCell.swift
//  Weather
//
//  Created by yadong.ye on 2017/7/23.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit

class ChartCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
