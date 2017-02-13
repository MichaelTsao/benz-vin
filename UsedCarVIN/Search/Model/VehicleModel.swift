//
//  VehicleModel.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class VehicleModel: NSObject {
    
    var title:String?                   //车title
    var location:String?                //产地
    var bornYear:String?                //生产年份
    var factory:String?                 //厂家名称
    var brand:String?                   //品牌
    var series:String?                  //车系
    var level:String?                   //车辆级别
    var type:String?                    //车辆类型
    var year:String?                    //年款
    var name:String?                    //销售名称
    var price:String?                   //指导价格
    var releaseYear:String?             //上市年份
    var releaseMonth:String?            //上市月份
    var stopYear:String?                //停产年份
    var code:String?                    //车型代码
    var carMode:String?                 //车型
    var effluent:String?                //排放标准
    var seatCount:String?               //座位数
    var gearbox:String?                 //变速箱类型
    var engineType:String?              //发动机型号
    var displacement:String?            //发动机排量
    var gearboxDescription:String?      //变速箱描述
    var power:String?                   //发动机最大功率
    var fuelType:String?                //燃油类型
    var doorCount:String?               //门数量
    var carType:String?                 //车身形式
    var fuelNo:String?                  //燃油标号
    var cylinderCount:String?           //发动机缸数
    var driveMode:String?               //驱动方式
    
    /*
     * 服务器取得车辆参数 2017年02月05日15:09:13
     */
    
    var vin:String?                   //VIN
    var regNo:String?                 //车牌
    var model:String?                 //车系
    var variant:String?               //车型字段
    var colour:String?                //颜色
    var trim:String?                  //内饰
    var prodDate:String?              //生产年份 Date
    var regDate:String?               //上牌日期 Date
    var age:String?                   //车龄 int
    var newPrice:String?              //新车指导价
    var averagePrice:String?          //均价
    var used:String?                  //过户次数
    var miles:String?                 //里程
    var repair:String?                //维修次数
    var orderRepair:String?           //一般维修次数
    var sprayRepair:String?                //喷漆维修次数
    var sheetMetal:String?                //钣金维修次数
    var claimDemage:String?                //索赔工作次数
    var maintain:String?                //保养规律与否
    var maintainTimes:String?                //保养次数
    var averageMiles:String?                //平均间隔里程
    var maintainDate:String?                //最后保养日期 ？
    

    
//    var vin:String? = nil {             //VIN
//        willSet{
//            if let value = newValue {
//                for daimler in VINInfoReader.shared.daimlerVINs {
//                    if daimler.vin == value {
//                        self.brand  = "奔驰"
//                        self.name   = daimler.modeCode
//                        self.detail = daimler.franModelVariant
//
//                        isDaimler = true
//                        print("Daimler.VIN = %@",daimler)
//                        break
//                    }
//                }
//            }
//        }
//    }

    var licensePlate:String? = nil {    //汽车牌照
        willSet{
            //from plate.csv
            if  let plate:String    = newValue,
                let plates  = PlateInfoReader.shared.daimlerPlates,
                let daimler = plates[plate] {

                self.vin      = daimler.vin
                self.carMode  = daimler.modeCode
                self.detail   = daimler.franModelVariant

                isDaimler = true
                print("Daimler.Plate = %@",daimler)
            }
        }
    }

    var detail:String?                  // Daimler 详情数据
    var isDaimler:Bool = false          // 是否属于Daimler数据

//    var title:String {
//        get{
//            return (brand ?? "") + " " + (name ?? "")
//        }
//    }
    
    func parse(with orcData:[String:String]) {
        self.location           = orcData["产地"]
        self.bornYear           = orcData["生产年份"]
        self.factory            = orcData["厂家名称"]
        self.brand              = orcData["品牌"]
        self.series             = orcData["车系"]
        self.level              = orcData["车辆级别"]
        self.type               = orcData["车辆类型"]
        self.year               = orcData["年款"]
        self.name               = orcData["销售名称"]
        self.price              = orcData["指导价格"]
        self.releaseYear        = orcData["上市年份"]
        self.releaseMonth       = orcData["上市月份"]
        self.stopYear           = orcData["停产年份"]
        self.code               = orcData["车型代码"]
        self.carMode            = orcData["车型"]
        self.effluent           = orcData["排放标准"]
        self.seatCount          = orcData["座位数"]
        self.gearbox            = orcData["变速箱类型"]
        self.engineType         = orcData["发动机型号"]
        self.displacement       = orcData["发动机排量"]
        self.gearboxDescription = orcData["变速箱描述"]
        self.power              = orcData["发动机最大功率"]
        self.fuelType           = orcData["燃油类型"]
        self.doorCount          = orcData["门数量"]
        self.carType            = orcData["车身形式"]
        self.fuelNo             = orcData["燃油标号"]
        self.cylinderCount      = orcData["发动机缸数"]
        self.driveMode          = orcData["驱动方式"]
        self.title = (brand ?? "") + " " + (series ?? "")
    }
    
    func parseJson(orcData:NSDictionary) {
        self.vin           = everyTypeToString(from: orcData.object(forKey: "vin")  ?? "")
        self.regNo           = everyTypeToString(from: orcData.object(forKey: "regNo")  ?? "")//车牌
        self.model           = everyTypeToString(from: orcData.object(forKey: "model")  ?? "")//车系
        self.variant           = everyTypeToString(from: orcData.object(forKey: "variant")  ?? "")//车型
        self.colour           = everyTypeToString(from: orcData.object(forKey: "colour")  ?? "")//颜色
        self.trim           = everyTypeToString(from: orcData.object(forKey: "trim") ?? "")//内饰
        self.prodDate = everyTypeToString(from: orcData.object(forKey: "prodDate") ?? "")//生产年份 Date
        self.regDate = everyTypeToString(from: orcData.object(forKey: "regDate") ?? "")//上牌日期
        self.age           = everyTypeToString(from: orcData.object(forKey: "age") ?? "")//车龄 int
        self.newPrice           = everyTypeToString(from: orcData.object(forKey: "newPrice") ?? "")//新车指导价
        self.averagePrice           = everyTypeToString(from: orcData.object(forKey: "averagePrice") ?? "")//均价
        self.used           = everyTypeToString(from: orcData.object(forKey: "used") ?? "")//过户次数
        self.miles           = everyTypeToString(from: orcData.object(forKey: "miles") ?? "")//里程
        self.repair           = everyTypeToString(from: orcData.object(forKey: "repair") ?? "")//维修次数
        self.orderRepair           = everyTypeToString(from: orcData.object(forKey: "orderRepair") ?? "")//一般维修次数
        self.sprayRepair           = everyTypeToString(from: orcData.object(forKey: "sprayRepair") ?? "")//喷漆维修次数
        self.sheetMetal           = everyTypeToString(from: orcData.object(forKey: "sheetMetal") ?? "")//钣金维修次数
        self.claimDemage           = everyTypeToString(from: orcData.object(forKey: "claimDemage") ?? "")//索赔工作次数
        self.maintain           = everyTypeToString(from: orcData.object(forKey: "maintain") ?? "")//保养规律与否
        self.maintainTimes           = everyTypeToString(from: orcData.object(forKey: "maintainTimes") ?? "")//保养次数
        self.averageMiles           = everyTypeToString(from: orcData.object(forKey: "averageMiles") ?? "")//平均间隔里程
        self.maintainDate = everyTypeToString(from: orcData.object(forKey: "maintainDate") ?? "")//最后维保日期
    }
    
}
