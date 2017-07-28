//
//  NetProtocol.swift
//  Weather
//
//  Created by 句芒 on 2017/7/28.
//  Copyright © 2017年 yadong.ye. All rights reserved.
//

import Foundation
import Alamofire
protocol Networkable {
    /**
     get 请求
     */
    func getRequest(url:String,_ params:[String:String],_ callBack:@escaping (String?)->())
}
extension Networkable {
    func getRequest(url:String,_ params:[String:String],_ callBack:@escaping (String?)->()) {
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (respones) in
            if respones.result.isFailure {
                return
            }
            
            guard let json = respones.result.value else{
                return
            }
            callBack(json)
        }
    }
}
