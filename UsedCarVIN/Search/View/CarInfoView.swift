//
//  CarInfoView.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class CarInfoView: BaseView {

    let titleLabel:UILabel = {
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    }()

//    lazy var vinLabel:UILabel          = CarInfoView.initLabel(titleLabel:"VIN")
//    lazy var locationLabel:UILabel     = CarInfoView.initLabel(titleLabel:"产地")
//    lazy var factoryLabel:UILabel      = CarInfoView.initLabel(titleLabel:"厂家")
//    lazy var bornLabel:UILabel         = CarInfoView.initLabel(titleLabel:"生产")
//    lazy var powerLabel:UILabel        = CarInfoView.initLabel(titleLabel:"发动机最大功率")
//    lazy var fuelLabel:UILabel         = CarInfoView.initLabel(titleLabel:"燃油类型")
//    lazy var cylindersLabel:UILabel    = CarInfoView.initLabel(titleLabel:"车牌")
//    lazy var carModeLabel:UILabel      = CarInfoView.initLabel(titleLabel:"车型")
//    lazy var priceLabel:UILabel        = CarInfoView.initLabel(titleLabel:"指导价格")
    
    lazy var vinLabel:UILabel          = CarInfoView.initLabel(titleLabel:"VIN")
    lazy var locationLabel:UILabel     = CarInfoView.initLabel(titleLabel:"颜色")
    lazy var factoryLabel:UILabel      = CarInfoView.initLabel(titleLabel:"车系")
    lazy var bornLabel:UILabel         = CarInfoView.initLabel(titleLabel:"车型")
    lazy var powerLabel:UILabel        = CarInfoView.initLabel(titleLabel:"车牌")
    lazy var fuelLabel:UILabel         = CarInfoView.initLabel(titleLabel:"内饰")
    lazy var cylindersLabel:UILabel    = CarInfoView.initLabel(titleLabel:"生产年份")
    lazy var carModeLabel:UILabel      = CarInfoView.initLabel(titleLabel:"上牌日期")
    lazy var priceLabel:UILabel        = CarInfoView.initLabel(titleLabel:"新车指导价")
    
    class func initLabel(titleLabel:String = "") -> UILabel {
        let label = UILabel()
        label.title = titleLabel+":"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }
    
    override func commonInit() {
        
        self.backgroundColor = UIColor.table_new_background
        
        self.addSubview(titleLabel)
        self.addSubview(vinLabel)
        self.addSubview(locationLabel)
        self.addSubview(factoryLabel)
        self.addSubview(bornLabel)
        self.addSubview(powerLabel)
        self.addSubview(fuelLabel)
        self.addSubview(cylindersLabel)
        self.addSubview(carModeLabel)
        self.addSubview(priceLabel)
        
        self.priceLabel.backgroundColor     = UIColor.white
        self.priceLabel.textColor           = UIColor.black
        self.priceLabel.layer.cornerRadius  = 4
        self.priceLabel.layer.masksToBounds = true
        self.priceLabel.textAlignment       = .center
        self.priceLabel.adjustsFontSizeToFitWidth = true

        super.commonInit()
    }

    override func updateConstraints() {

        if (didSetupConstraints == false){
            let superview = self

            let leftPadding:CGFloat = 30
            let vPadding:CGFloat    = 5
            let labelHeight:CGFloat = 20

            self.titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(superview).offset(10)
                make.right.equalTo(superview).offset(-leftPadding)
                make.height.equalTo(leftPadding)
            }

            let whiteView = UIView.color(with: .white)
            self.addSubview(whiteView)

            whiteView.snp.makeConstraints { (make) in
                make.width.equalTo(2)
                make.height.equalTo(20)
                make.centerY.equalTo(titleLabel)
                make.left.equalTo(superview).offset(leftPadding/2-1)
            }

            self.vinLabel.snp.makeConstraints { (make) in
                make.left.equalTo(titleLabel)
                make.top.equalTo(titleLabel.snp.bottom).offset(vPadding * 2)
                make.width.equalTo(superview).multipliedBy(0.7)
                make.height.equalTo(labelHeight)
            }

            self.locationLabel.snp.makeConstraints { (make) in
                make.left.equalTo(titleLabel)
                make.top.equalTo(vinLabel.snp.bottom).offset(vPadding)
                make.width.equalTo(80)
                make.height.equalTo(labelHeight)
            }

            self.factoryLabel.snp.makeConstraints { (make) in
                make.left.equalTo(locationLabel.snp.right).offset(vPadding)
                make.top.equalTo(locationLabel)
                make.width.equalTo(100)
                make.height.equalTo(labelHeight)
            }

            self.bornLabel.snp.makeConstraints { (make) in
                make.left.equalTo(factoryLabel.snp.right).offset(vPadding)
                make.top.equalTo(locationLabel)
                make.width.equalTo(100)
                make.height.equalTo(labelHeight)
            }

            self.powerLabel.snp.makeConstraints { (make) in
                make.left.equalTo(titleLabel)
                make.top.equalTo(locationLabel.snp.bottom).offset(vPadding)
                make.height.equalTo(labelHeight)
            }

            self.fuelLabel.snp.makeConstraints { (make) in
                make.left.equalTo(powerLabel.snp.right).offset(vPadding)
                make.right.equalTo(titleLabel.snp.right)
                make.top.equalTo(locationLabel.snp.bottom).offset(vPadding)
                make.height.equalTo(labelHeight)
                make.width.equalTo(superview.powerLabel)
            }

            self.cylindersLabel.snp.makeConstraints { (make) in
                make.left.equalTo(titleLabel)
                make.top.equalTo(powerLabel.snp.bottom).offset(vPadding)
                make.height.equalTo(labelHeight)
            }

            self.carModeLabel.snp.makeConstraints { (make) in
                make.left.equalTo(cylindersLabel.snp.right).offset(vPadding)
                make.right.equalTo(titleLabel)
                make.top.equalTo(powerLabel.snp.bottom).offset(vPadding)
                make.width.equalTo(cylindersLabel)
                make.height.equalTo(labelHeight)
            }
            
            self.priceLabel.snp.makeConstraints { (make) in
                make.left.equalTo(titleLabel)
                make.top.equalTo(cylindersLabel.snp.bottom).offset(vPadding)
                make.width.equalTo(120)
                make.height.equalTo(labelHeight)
            }
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    deinit {
        print("deinit \(self)")
    }
}
