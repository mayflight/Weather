//
//  WindCell.swift
//  Weather
//
//  Created by 句芒 on 2017/7/25.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit

class WindCell: UITableViewCell,BezierPathAnimateable,Sizeable {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }

    @IBOutlet weak var fourWeather: UILabel!
    @IBOutlet weak var threeWeather: UILabel!
    @IBOutlet weak var twoWeather: UILabel!
    @IBOutlet weak var oneWeather: UILabel!
    @IBOutlet weak var fourDay: UILabel!
    @IBOutlet weak var twoDay: UILabel!
    @IBOutlet weak var threeDay: UILabel!
    @IBOutlet weak var oneDay: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    @IBOutlet weak var windPower: UILabel!
    @IBOutlet weak var leafImageView: UIImageView!
    
    func animate() {
        bezierAnimate(leafImageView, points: [CGPoint(x:0,y:height),CGPoint(x:width,y:height/2),CGPoint(x:width/3,y:-30),CGPoint(x:width/3*2,y:height+30)])
        bezierAnimate(windPower, points: [CGPoint(x:0,y:0),CGPoint(x:width,y:height/3*2),CGPoint(x:width/3,y:height),CGPoint(x:width/3*2,y:0)])
        bezierAnimate(windDirection, points: [CGPoint(x:0,y:height/2),CGPoint(x:width,y:height),CGPoint(x:width/3,y:height/10),CGPoint(x:width/3*2,y:height)])
    }
    
    func updateContent(_ days:[String]?,_ weathers:[String?]?)  {
        var daysLabels = [oneDay,twoDay,threeDay,fourDay]
        var weatherLabels = [oneWeather,twoWeather,threeWeather,fourWeather]
        _ =  days?.enumerated().map(){
            if $0 < days!.count {
                daysLabels[$0]?.text = $1
            }
        }
        _ = weathers?.enumerated().map(){
            if $0 < weathers!.count {
                weatherLabels[$0]?.text = $1
            }
        }
    
    }
    
}
