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
        self.chartDescription?.text = "峰谷温度走势"
        self.leftAxis.enabled = false
        self.rightAxis.drawAxisLineEnabled = false
        self.rightAxis.drawGridLinesEnabled = false
        self.xAxis.drawGridLinesEnabled = false
        self.drawGridBackgroundEnabled = false
        self.drawBordersEnabled = false
        self.dragEnabled = true
        self.setScaleEnabled(false)
        self.pinchZoomEnabled = false
        self.legend.horizontalAlignment = .right
        self.legend.verticalAlignment = .bottom
        self.legend.orientation = .horizontal
        self.legend.drawInside = false
        self.xAxis.granularity = 1
        self.xAxis.labelCount = 5
        self.xAxis.drawAxisLineEnabled = true
        self.xAxis.labelPosition = .bottom
        self.xAxis.avoidFirstLastClippingEnabled = true
    }
    
    func setLineData(_ hight:[Double]?,_ lower:[Double]?,_ dates:[String]?) {
        if hight == nil || lower == nil || dates == nil {
            return
        }
        self.xAxis.valueFormatter = DefaultAxisValueFormatter(block: { (index, _) -> String in
            return "\(dates![(Int(index))])"
        })
        self.rightAxis.valueFormatter = DefaultAxisValueFormatter(block: { (index, _) -> String in
            return "\(index)℃"
        })
 
        let lineHigh = getLine(datas: hight!, colors:append(UIColor.red, 5), text: "最高温度")
        let lineLow = getLine(datas: lower!, colors: append(UIColor.init(red: 38.0/255, green: 186.0/255, blue: 206.0/255, alpha: 1), 5), text: "最低温度")
        let data = LineChartData(dataSets: [lineHigh,lineLow])
        data.setValueFont(UIFont.systemFont(ofSize: 10))
        self.data = data
    }
    
    func getLine(datas:[Double],colors:[UIColor],text:String) -> LineChartDataSet {
        let dataEntrys:[ChartDataEntry] = datas.enumerated().map { (index,value) -> ChartDataEntry in
            return ChartDataEntry(x: Double(index), y: value)
        }
        let line = LineChartDataSet(values: dataEntrys, label: text)
        line.lineWidth = 2
        line.circleRadius = 2
        line.circleHoleRadius = 1
        line.lineDashLengths = [5,5]
        line.colors = colors
        line.setCircleColor(UIColor.green)
        line.mode = .horizontalBezier
        return line
    }
    
    func append<T>(_ value:T,_ count:Int) -> [T] {
        var array:[T] = Array()
        var i = 0
        while i <= count {
            array.append(value)
            i += 1
        }
        return array
    }
}
