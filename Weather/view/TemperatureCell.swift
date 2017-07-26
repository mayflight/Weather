//
//  TemperatureCell.swift
//  Weather
//
//  Created by yadong.ye on 2017/7/21.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit

class TemperatureCell: UITableViewCell {
    
    var temperature:Float? {
        didSet {
            guard let tem = temperature else {
                return
            }
            temperatureView.updateContent(progress: tem/100.0, "气温:\(tem)")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }

    
    @IBOutlet weak var temperatureView: UIAnnularProgress!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
