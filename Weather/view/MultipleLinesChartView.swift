//
//  MultipleLinesChartView.swift
//  Weather
//
//  Created by yadong.ye on 2017/7/23.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit
import Charts
class MultipleLinesChartView: LineChartView{
    override func awakeFromNib() {
        
        self.noDataText = "暂无数据"
        self.leftAxis.enabled = false
        self.rightAxis.drawAxisLineEnabled = false
        self.rightAxis.drawGridLinesEnabled = false
        self.xAxis.drawAxisLineEnabled = false
        self.xAxis.drawGridLinesEnabled = false
        self.xAxis.labelPosition = .bottom
        
        self.drawGridBackgroundEnabled = false
        self.drawBordersEnabled = false
        self.dragEnabled = false
        self.setScaleEnabled(true)
        self.pinchZoomEnabled = false
        self.legend.horizontalAlignment = .right
        self.legend.verticalAlignment = .top
        self.legend.orientation = .vertical
        self.legend.drawInside = false
        
        self.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["7月1","7月2","7月3","7月4","7月5"])
        
        let line =  LineChartDataSet(values: [ChartDataEntry(x: 1, y: 1.2),ChartDataEntry(x: 2, y: 4.2),ChartDataEntry(x: 3, y: 3.1),ChartDataEntry(x: 4, y: 5.2),ChartDataEntry(x: 5, y: 2.2)], label: "温度")
        
        line.lineWidth = 2
        line.circleRadius = 2
        line.circleHoleRadius = 1
        line.lineDashLengths = [5,5]
        line.colors = [UIColor.red,UIColor.red,UIColor.red,UIColor.red,UIColor.red]
        line.setCircleColor(UIColor.green)
        let data = LineChartData(dataSets: [line])
        data.setValueFont(UIFont.systemFont(ofSize: 7))
        self.data = data
    }
    
    func setLineData(_ hightLines:[Double],_lower:[Double]) {
        
    }
    
}
