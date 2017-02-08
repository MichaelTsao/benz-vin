//
//  VehicleDetailViewController.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/26.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class VehicleDetailViewController: BaseViewController {

     var dataArray:[(String,String,Bool)] = []

    let spaceView:UIView = {
        return UIView.color(with: UIColor.white)
    }()
    let titleView:CarTitleView = {
        let titleView = CarTitleView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return titleView
    }()
    let tableView:UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.separatorStyle = .none
        return tableview
    }()

    var model:VehicleModel? = nil {
        willSet{
            if let value = newValue {

                self.titleView.titleLabel.text     = value.title
                self.titleView.vinLabel.value      = value.vin
                
                self.titleView.locationLabel.value = value.location
                self.titleView.factoryLabel.value  = value.model
                self.titleView.bornLabel.value     = value.variant
                self.titleView.carModeLabel.value  = value.regDate
                self.titleView.plateLabel.value    = value.regNo
//                self.titleView.priceLabel.value    =  value.price
                
                if let number = value.newPrice { // 建议的做法
                    self.titleView.priceLabel.value = String(describing:number)
                }else{
                    self.titleView.priceLabel.value = ""
                }
                
//                self.setDetailValue(key: "车型", value: "",isSection: true)
//                self.setDetailValue(key: "车型代码", value: value.code)
//                self.setDetailValue(key: "上市年份", value: value.releaseYear)
//                self.setDetailValue(key: "停产年份", value: value.stopYear)
//                self.setDetailValue(key: "车辆级别", value: value.level)
//                self.setDetailValue(key: "车辆类型", value: value.type)

//                self.setDetailValue(key: "车身", value: "",isSection: true)

//                self.setDetailValue(key: "排放标准",  value: value.effluent)
//                self.setDetailValue(key: "座位数",    value: value.seatCount)
//                self.setDetailValue(key: "变速箱类型", value: value.gearbox)
//                self.setDetailValue(key: "变速箱描述", value: value.gearboxDescription)
//                self.setDetailValue(key: "车门数",     value: value.doorCount)
//                self.setDetailValue(key: "车身形式",   value: value.carType)
//                self.setDetailValue(key: "驱动方式",    value: value.driveMode)

//                self.setDetailValue(key: "发动机", value: "",isSection: true)

//                self.setDetailValue(key: "燃油标号",      value: value.fuelNo)
//                self.setDetailValue(key: "发动机缸数",    value: value.cylinderCount)
//                self.setDetailValue(key: "发动机型号",    value: value.engineType)
//                self.setDetailValue(key: "排量",         value: value.displacement)
//                self.setDetailValue(key: "发动机最大功率", value: value.power)
//                self.setDetailValue(key: "燃油类型",      value: value.fuelType)

                
                self.setDetailValue(key: "其他情况", value: "",isSection: true)
                
                self.setDetailValue(key: "生成年份",    value: value.prodDate)

//                self.setDetailValue(key: "车龄",      value: value.age)
                if let number = value.age {
                    self.setDetailValue(key: "车龄", value: String(describing:number))
                }
                if let number = value.used {
                    self.setDetailValue(key: "过户次数", value: String(describing:number))
                }
                if let number = value.miles {
                    self.setDetailValue(key: "里程", value: String(describing:number))
                }
                if let number = value.repair {
                    self.setDetailValue(key: "维修次数", value: String(describing:number))
                }
                if let number = value.orderRepair {
                    self.setDetailValue(key: "一般维修次数", value: String(describing:number))
                }
                if let number = value.sprayRepair {
                    self.setDetailValue(key: "喷漆维修次数", value: String(describing:number))
                }
                if let number = value.sheetMetal {
                    self.setDetailValue(key: "钣金维修次数", value: String(describing:number))
                }
                if let number = value.claimDemage {
                    self.setDetailValue(key: "索赔工作次数", value: String(describing:number))
                }
                self.setDetailValue(key: "保养规律与否",      value: value.maintain)
                if let number = value.maintainTimes {
                    self.setDetailValue(key: "保养次数", value: String(describing:number))
                }
                if let number = value.averageMiles {
                    self.setDetailValue(key: "平均间隔里程", value: String(describing:number))
                }
//                self.regNo           = orcData.object(forKey: "regNo") as! String?//车牌
//                self.model           = orcData.object(forKey: "model") as! String?//车系
//                self.variant           = orcData.object(forKey: "variant") as! String?//车型
//                self.colour           = orcData.object(forKey: "colour") as! String?//颜色
//                self.trim           = orcData.object(forKey: "trim") as! String?//内饰
//                self.prodDate      = orcData.object(forKey: "prodDate") as! String?//生产年份 Date
//                self.regDate           = orcData.object(forKey: "regDate") as! String?//上牌日期 Date
//                self.age           = orcData.object(forKey: "age") as! Int?//车龄 int
//                self.newPrice           = orcData.object(forKey: "newPrice") as! Int?//新车指导价
//                self.used           = orcData.object(forKey: "used") as! Int?//过户次数
//                self.miles           = orcData.object(forKey: "miles") as! Int?//里程
//                self.repair           = orcData.object(forKey: "repair") as! Int?//维修次数
//                self.orderRepair           = orcData.object(forKey: "orderRepair") as! Int?//一般维修次数
//                self.sprayRepair           = orcData.object(forKey: "sprayRepair") as! Int?//喷漆维修次数
//                self.sheetMetal           = orcData.object(forKey: "sheetMetal") as! Int?//钣金维修次数
//                self.claimDemage           = orcData.object(forKey: "claimDemage") as! Int?//索赔工作次数
//                self.maintain           = orcData.object(forKey: "maintain") as! String?//保养规律与否
//                self.maintainTimes           = orcData.object(forKey: "maintainTimes") as! Int?//保养次数
//                self.averageMiles           = orcData.object(forKey: "averageMiles") as! Int?//平均间隔里程
                
                self.tableView.reloadData()
            }
        }
    }

    private func setDetailValue(key:String,value:String?,isSection:Bool = false){
//        guard let value = value else {
//            return
//        }
        self.dataArray.append((key,value ?? "",isSection))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "详细信息"
        self.isHiddenTabbar = true
    }
    
    override func commonInit() {

        let titleViiew = self.titleView
        self.titleView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220)
        self.tableView.tableHeaderView = titleViiew
        self.tableView.delegate        = self
        self.tableView.dataSource      = self

        self.view.addSubview(self.spaceView)
        self.view.addSubview(self.tableView)

        super.commonInit()
    }

    override func updateViewConstraints() {

        if didSetupConstraints == false {

            self.spaceView.snp.makeConstraints({ (make) in
                make.left.right.equalTo(self.view)
                make.top.equalTo(self.view).offset(64)
                make.height.equalTo(5)
            })

            self.tableView.snp.makeConstraints({ (make) in
                make.left.bottom.right.equalTo(self.view)
                make.top.equalTo(self.spaceView.snp.bottom)
            })

            didSetupConstraints = true
        }

        super.updateViewConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setRightBarNavigationItem() {

        guard let barButtonItem   = UIBarButtonItem.whiteBackButton(),
            let button:UIButton = barButtonItem.customView as? UIButton else {
                return
        }

        self.navigationItem.leftBarButtonItem = barButtonItem

        button.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
    }

    deinit {
        print("deinit \(self)")
    }
}

extension VehicleDetailViewController:UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifierString = DetailTableViewCell.reuseIdentifierString!

        var cell = tableView.dequeueReusableCell(withIdentifier: identifierString) as? DetailTableViewCell

        if  cell == nil {
            cell = DetailTableViewCell(style: .default, reuseIdentifier: identifierString)
        }

        let data:(title:String,value:String,isSection:Bool) = self.dataArray[indexPath.row]

        cell?.title = data.title
        cell?.value = data.value
        cell?.isSection = data.isSection

        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return DetailTableViewCell.cellHeight()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
