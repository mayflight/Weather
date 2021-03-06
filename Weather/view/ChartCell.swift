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
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }

    @IBOutlet weak var chartView: MultipleLinesChartView!
    
    func updateContent(_ hight:[Double]?,_ lower:[Double]?,_ dates:[String]?)  {
        chartView .setLineData(hight,lower,dates)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
