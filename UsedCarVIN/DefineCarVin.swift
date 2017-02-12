//
//  DefineCarVin.swift
//  UsedCarVIN
//
//  Created by DreamTeamAAn on 2017/2/9.
//  Copyright © 2017年 daimler. All rights reserved.
//

import Foundation

let kIOS7 = Int(UIDevice().systemVersion)! >= 7 ? 1 : 0

let CARVIN_API_URL = "http://120.77.66.101:8888/"
//let CARVIN_API_URL = "https://oabint1.mercedes-benz.com.cn/vin/"
//let path = "http://120.77.66.101:8888/Vehicle?VIN=4JG1641861A35516"//4JG1641861A355196
//        let path = "http://120.77.66.101:8888/Vehicle/History?VIN=4JG1641861A355196"

//class DefineCarVin
//{
//    let kIOS7 = Double(UIDevice().systemVersion)>=7.0 ? 1 :0
//}

//强制转换字符串
func everyTypeToString(from: Any) -> String {
    var result = ""
    result =  NSString.init(format:"%@",from as! CVarArg) as String
    
    if result == "<null>" {
        return ""
    }
    
    return result
}
