//
//  UIAnnularProgress.swift
//  Weather
//
//  Created by yadong.ye on 2017/7/21.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import UIKit


struct ProgressProperty{
    var width:CGFloat
    var trackColor:UIColor
    var progressColor :UIColor
    var progressStart:CGFloat
    var progressEnd:CGFloat
    var text:String?
    
    init(width:CGFloat,progressEnd:CGFloat,progressColor:UIColor) {
        self.width = width
        self.progressEnd = progressEnd
        self.progressColor = progressColor
        trackColor = UIColor.gray
        progressStart = 0.0
    }
    
    init() {
        width = 10
        trackColor = UIColor.gray
        progressColor = UIColor.red
        progressStart = 0.0
        progressEnd = 0.25
    }
}

class UIAnnularProgress: UIView {

    var progressProperty:ProgressProperty
    private let progressLayer = CAShapeLayer()
    
    
    
    init(propressProperty:ProgressProperty,frame:CGRect) {
        self.progressProperty = propressProperty
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        progressProperty = ProgressProperty.init(width: 10, progressEnd: 0, progressColor: UIColor.green)
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {

        let path = UIBezierPath(ovalIn: bounds).cgPath
        let trackLayer = CAShapeLayer()
        trackLayer.frame = bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = progressProperty.trackColor.cgColor
        trackLayer.lineWidth = progressProperty.width
        trackLayer.path = path
        layer.addSublayer(trackLayer)
        
        let style = NSMutableParagraphStyle.init()
        style.alignment = .center
        
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 30),
                          NSForegroundColorAttributeName: UIColor.orange,
                          NSParagraphStyleAttributeName: style]
        let frame = CGRect(x: 0, y: bounds.size.height/2-30, width: bounds.size.width, height: 60)
        progressProperty.text?.draw(in:frame, withAttributes:attributes)
        
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressProperty.progressColor.cgColor
        progressLayer.lineWidth = progressProperty.width
        progressLayer.path = path
        progressLayer.strokeStart = progressProperty.progressStart
        progressLayer.strokeEnd = progressProperty.progressEnd
        layer.addSublayer(progressLayer)
        
    }
    
    
    func setProgress(progress:Float,time:CFTimeInterval,animate:Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(!animate)
        CATransaction.setAnimationDuration(time)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        progressLayer.strokeEnd = progressProperty.progressEnd
        CATransaction.commit()
    }
    
    func updateContent(progress:Float,_ text:String?)  {
        progressProperty.text = text
        progressProperty.progressEnd = CGFloat(progress)
        setNeedsDisplay()
        setProgress(progress: progress, time: 3, animate: true)
    }
}
