//
//  MaintenanceModel.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/21.
//  Copyright © 2016年 daimler. All rights reserved.
//

import Foundation

class MaintenanceModel: NSObject {
    
    var type:String?
    var kilometres:String?
    var date:String?
    var component:String?
    var content:String?
    
    
    var regNo:String?//"":"京NXX651",
    var maintainDate:String?//"":"2014-10-17",
    var details:String?//"":"保养",
    var desc:String?//"AMG 0W40 MB229.5/A保养检查更换机油机滤/刹车片/刹车片 后ML/刹车防响膏/拆卸/安装前后车轮/摩擦片磨损传感器/更换前轴的制动摩擦衬块/更换后轴制动摩擦衬块/机油滤芯",
    var miles:String?//60976,
    var sanName:String?//null,
    var vin:String?//4JG1641861A355196
    
    
}
