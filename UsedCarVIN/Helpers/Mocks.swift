//
//  Mocks.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/21.
//  Copyright © 2016年 daimler. All rights reserved.
//

import Foundation

struct Mocks {

    let vehicle1:VehicleModel = {

        let model = VehicleModel()

        model.vin                = "LE42040481L1207212"

        model.licensePlate       = "京P077W7"

        model.name               = "2.0T 手自一体 运动型"
        model.location           = "中国"
        model.factory            = "北京奔驰"
        model.bornYear           = "2014年"
        model.power              = "165"
        model.fuelType           = "汽油"
        model.cylinderCount      = "4"
        model.price              = "44.8万"

        model.code               = "CAF7180N48"
        model.releaseYear        = "2013-06-18"
        model.stopYear           = "2016-10-18"
        model.year               = "2014"
        model.level              = "紧凑型车"
        model.type               = "轿车"
        model.effluent           = "国4"
        model.seatCount          = "5"
        model.gearbox            = "自动"
        model.gearboxDescription = "自动变速器(AT)"
        model.doorCount          = "4门"
        model.carType            = "三厢"
        model.carMode            = "Class级-三厢"
        model.driveMode          = "四轮驱动"
        model.fuelNo             = "95#"
        model.cylinderCount      = "4"
        model.engineType         = "CAF483Q0"
        model.displacement       = "105"
        model.fuelType           = "汽油"

        return model
    }()



    let vehicle2:VehicleModel = {

        let model = VehicleModel()

        model.vin           = "LVSFCAMEX8F265694"

        model.licensePlate  = "京B 68A26"

        model.name          = "1.8 手动 酷白典藏版"
        model.location      = "中国"
        model.factory       = "长安福特"
        model.bornYear      = "2008年"
        model.power         = "91"
        model.fuelType      = "汽油"
        model.cylinderCount = "4"
        model.driveMode     = "前轮驱动"
        model.price         = "11.38万"

        return model
    }()

    let vehicle3:VehicleModel = {

        let model = VehicleModel()

        model.vin = "LE42040481L1209440"

        model.licensePlate  = "闽A7J981"

        model.name          = "1.8T 手自一体 优雅型"
        model.location      = "中国"
        model.factory       = "北京奔驰"
        model.bornYear      = "2012年"
        model.power         = "135"
        model.fuelType      = "汽油"
        model.cylinderCount = "4"
        model.driveMode     = "后轮驱动"
        model.price         = "34.8万"

        return model
    }()


    let maintenance1:MaintenanceModel = {

        let model = MaintenanceModel()

        model.type       = "保修"
        model.kilometres = "10429公里"
        model.date       = "2015-03-08"
        model.component  = "前保险杠"
        model.content    = "更换保险杠"

        return model
    }()

    let maintenance2:MaintenanceModel = {

        let model = MaintenanceModel()

        model.type       = "保养"
        model.kilometres = "19626公里"
        model.date       = "2015-08-13"
        model.component  = "发动机"
        model.content    = "机油保养"
        
        return model
    }()
    
    let maintenance3:MaintenanceModel = {
        
        let model = MaintenanceModel()
        
        model.type       = "维修"
        model.kilometres = "40027公里"
        model.date       = "2016-07-01"
        model.component  = "空调"
        model.content    = "更换氟管密封圈"
        
        return model
    }()
    
}
