//
//  locationProtocol.swift
//  Weather
//
//  Created by 句芒 on 2017/7/28.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

typealias LocationResult = (CLLocation,CLPlacemark) -> ()



class LocationManager : NSObject, CLLocationManagerDelegate{
  
    
    let manager = CLLocationManager()
    private var result:LocationResult? = nil
    
    func startLocation(accuracy:CLLocationAccuracy = kCLLocationAccuracyKilometer, distance:CLLocationDistance = 1000, _ result:@escaping LocationResult) {
        manager.delegate = self
        manager.desiredAccuracy = accuracy
        manager.distanceFilter = distance
        if CLLocationManager.authorizationStatus() == .denied {
            requestLocationAuthor()
        }
        if #available(iOS 8.0, *) {
            manager.requestWhenInUseAuthorization()
        }
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        self.result = result
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let location = locations.last else {
            return
        }
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            guard let mark = placemarks?.last else {
                return
            }
            if self.result != nil {
                self.result!(location,mark)
            }
        }
    }

    func requestLocationAuthor() {
        guard let controller = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        controller.alert("前往设置页面开启应用定位权限", rightTitle: "设置") {
            guard let url = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            UIApplication.shared.open(url, options:[:], completionHandler: nil)
        }

    }
}

