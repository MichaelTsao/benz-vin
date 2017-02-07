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
        label.textColor = UIColor.title_label_text_color
        return label
    }()
    
    //车款车系
    lazy var carModelsLabelTip:UILabel    = CarInfoView.initLabelTip(titleLabel:"车款车系")
    lazy var carModelsLabel:UILabel       = CarInfoView.initLabel(titleLabel:"")
    
    //新车指导价格
    lazy var priceLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"新车指导价")
    lazy var priceLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")
    
    //上牌日期
    lazy var registrationDateLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"上牌日期")
    lazy var registrationDateLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")
    
    
    //生产日期
    lazy var productDateLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"生产年份")
    lazy var productDateLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")
    
    //是否在质保期
    lazy var warrantyPeriodLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"在质保期")
    lazy var warrantyPeriodLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")
    
    //过户次数
    lazy var usedLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"过户")
    lazy var usedLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")
    
    //车龄
    lazy var ageLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"车龄")
    lazy var ageLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")
    
    //里程
    lazy var milesLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"里程")
    lazy var milesLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")
    
    

    
    
//    lazy var vinLabel:UILabel          = CarInfoView.initLabel(titleLabel:"VIN")
//    lazy var locationLabel:UILabel     = CarInfoView.initLabel(titleLabel:"颜色")
//    lazy var factoryLabel:UILabel      = CarInfoView.initLabel(titleLabel:"车系")
//    lazy var bornLabel:UILabel         = CarInfoView.initLabel(titleLabel:"车型")
//    lazy var powerLabel:UILabel        = CarInfoView.initLabel(titleLabel:"车牌")
//    lazy var fuelLabel:UILabel         = CarInfoView.initLabel(titleLabel:"内饰")
//    lazy var cylindersLabel:UILabel    = CarInfoView.initLabel(titleLabel:"生产年份")
//    lazy var carModeLabel:UILabel      = CarInfoView.initLabel(titleLabel:"上牌日期")
    

    
    class func initLabelTip(titleLabel:String = "") -> UILabel {
        let label = UILabel()
        label.title = titleLabel
        label.textColor = UIColor.label_tip_color
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }
    
    class func initLabel(titleLabel:String = "") -> UILabel {
        let label = UILabel()
        label.title = ""
        label.textColor = UIColor.label_text_color
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    
    
    override func commonInit() {
        
        self.backgroundColor = UIColor.table_new_background
        
        self.addSubview(titleLabel)
        
        self.addSubview(carModelsLabelTip)
        self.addSubview(carModelsLabel)
        
        self.addSubview(priceLabelTip)
        self.addSubview(priceLabel)
        
        self.addSubview(registrationDateLabelTip)
        self.addSubview(registrationDateLabel)
        
        self.addSubview(productDateLabelTip)
        self.addSubview(productDateLabel)
        
        
        self.addSubview(warrantyPeriodLabelTip)
        self.addSubview(warrantyPeriodLabel)
        
        self.addSubview(usedLabelTip)
        self.addSubview(usedLabel)
        
        
        
        self.addSubview(ageLabelTip)
        self.addSubview(ageLabel)
        
        self.addSubview(milesLabelTip)
        self.addSubview(milesLabel)
        
        
//        self.addSubview(vinLabel)
//        self.addSubview(locationLabel)
//        self.addSubview(factoryLabel)
//        self.addSubview(bornLabel)
//        self.addSubview(powerLabel)
//        self.addSubview(fuelLabel)
//        self.addSubview(cylindersLabel)
//        self.addSubview(carModeLabel)
        
        titleLabel.textAlignment = .center
        
//        self.priceLabel.backgroundColor     = UIColor.white
//        self.priceLabel.textColor           = UIColor.black
//        self.priceLabel.layer.cornerRadius  = 4
//        self.priceLabel.layer.masksToBounds = true
//        self.priceLabel.textAlignment       = .center
//        self.priceLabel.adjustsFontSizeToFitWidth = true

        super.commonInit()
    }

    override func updateConstraints() {

        if (didSetupConstraints == false){
            let superview = self

            let leftPadding:CGFloat = 30
            let vPaddingA:CGFloat    = 5
            let vPaddingB:CGFloat    = 7
            let vPaddingC:CGFloat    = 15
            let labelTipHeight:CGFloat = 20
            let labelHeight:CGFloat = 20
            let labelwidth:CGFloat = 160

            
            
            self.titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(superview).offset(vPaddingA)
                make.right.equalTo(superview).offset(-leftPadding)
                make.height.equalTo(leftPadding)
            }
            
//            let whiteView = UIView.color(with: .white)
//            self.addSubview(whiteView)
//
//            whiteView.snp.makeConstraints { (make) in
//                make.width.equalTo(2)
//                make.height.equalTo(20)
//                make.centerY.equalTo(titleLabel)
//                make.left.equalTo(superview).offset(leftPadding/2-1)
//            }
            
            self.carModelsLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(titleLabel.snp.bottom).offset(vPaddingC)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.carModelsLabel.snp.makeConstraints { (make) in
                make.left.equalTo(carModelsLabelTip)
                make.right.equalTo(carModelsLabelTip)
                make.top.equalTo(carModelsLabelTip.snp.bottom).offset(vPaddingB)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.priceLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(carModelsLabelTip.snp.right).offset(leftPadding)
                make.top.equalTo(titleLabel.snp.bottom).offset(vPaddingC)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.priceLabel.snp.makeConstraints { (make) in
                make.left.equalTo(priceLabelTip)
                make.right.equalTo(priceLabelTip)
                make.top.equalTo(priceLabelTip.snp.bottom).offset(vPaddingB)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            
            
            // 上牌日期，生产年份
            self.registrationDateLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(priceLabel.snp.bottom).offset(vPaddingC)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.registrationDateLabel.snp.makeConstraints { (make) in
                make.left.equalTo(registrationDateLabelTip)
                make.right.equalTo(registrationDateLabelTip)
                make.top.equalTo(registrationDateLabelTip.snp.bottom).offset(vPaddingB)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            
            self.productDateLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(registrationDateLabelTip.snp.right).offset(leftPadding)
                make.top.equalTo(registrationDateLabelTip)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.productDateLabel.snp.makeConstraints { (make) in
                make.left.equalTo(productDateLabelTip)
                make.right.equalTo(productDateLabelTip)
                make.top.equalTo(registrationDateLabel)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            
            
            // 在质保期，过户
            self.warrantyPeriodLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(productDateLabel.snp.bottom).offset(vPaddingC)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.warrantyPeriodLabel.snp.makeConstraints { (make) in
                make.left.equalTo(warrantyPeriodLabelTip)
                make.top.equalTo(warrantyPeriodLabelTip.snp.bottom).offset(vPaddingB)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.usedLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(warrantyPeriodLabelTip.snp.right).offset(leftPadding)
                make.top.equalTo(warrantyPeriodLabelTip)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.usedLabel.snp.makeConstraints { (make) in
                make.left.equalTo(usedLabelTip)
                make.top.equalTo(warrantyPeriodLabel)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            

            
            // 车龄、公里数
            self.ageLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(usedLabel.snp.bottom).offset(vPaddingC)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.ageLabel.snp.makeConstraints { (make) in
                make.left.equalTo(ageLabelTip)
                make.top.equalTo(ageLabelTip.snp.bottom).offset(vPaddingB)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.milesLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(ageLabelTip.snp.right).offset(leftPadding)
                make.top.equalTo(ageLabelTip)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.milesLabel.snp.makeConstraints { (make) in
                make.left.equalTo(milesLabelTip)
                make.top.equalTo(ageLabel)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            /*
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
            
*/
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    deinit {
        print("deinit \(self)")
    }
}
