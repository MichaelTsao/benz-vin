//
//  CarTitleView.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/26.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class CarTitleView: BaseView {

    let titleLabel:UILabel = {
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()
    let vinLabel:UILabel = {
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.title = "VIN:"
        return label
    }()

//    lazy var locationLabel:UILabel     = CarTitleView.initLabel(titleLabel:"产地")
//    lazy var factoryLabel:UILabel      = CarTitleView.initLabel(titleLabel:"厂家")
//    lazy var bornLabel:UILabel         = CarTitleView.initLabel(titleLabel:"生产")
//    lazy var carModeLabel:UILabel      = CarTitleView.initLabel(titleLabel:"车型")
//    lazy var plateLabel:UILabel        = CarTitleView.initLabel(titleLabel:"车牌")
//    lazy var priceLabel:UILabel        = CarTitleView.initLabel(titleLabel:"指导价格")
    
    
    lazy var locationLabel:UILabel     = CarTitleView.initLabel(titleLabel:"颜色")
    lazy var factoryLabel:UILabel      = CarTitleView.initLabel(titleLabel:"车系")
    lazy var bornLabel:UILabel         = CarTitleView.initLabel(titleLabel:"车型")
    lazy var carModeLabel:UILabel      = CarTitleView.initLabel(titleLabel:"上牌日期")
    lazy var plateLabel:UILabel        = CarTitleView.initLabel(titleLabel:"车牌")
    lazy var priceLabel:UILabel        = CarTitleView.initLabel(titleLabel:"指导价格")
    
//    lazy var vinLabel:UILabel          = CarInfoView.initLabel(titleLabel:"VIN")
//    lazy var locationLabel:UILabel     = CarInfoView.initLabel(titleLabel:"颜色")
//    lazy var factoryLabel:UILabel      = CarInfoView.initLabel(titleLabel:"车系")
//    lazy var bornLabel:UILabel         = CarInfoView.initLabel(titleLabel:"车型")
//    lazy var powerLabel:UILabel        = CarInfoView.initLabel(titleLabel:"车牌")
//    lazy var fuelLabel:UILabel         = CarInfoView.initLabel(titleLabel:"内饰")
//    lazy var cylindersLabel:UILabel    = CarInfoView.initLabel(titleLabel:"生产年份")
//    lazy var carModeLabel:UILabel      = CarInfoView.initLabel(titleLabel:"上牌日期")
//    lazy var priceLabel:UILabel        = CarInfoView.initLabel(titleLabel:"新车指导价")
    
    class func initLabel(titleLabel:String = "") -> UILabel {
        let label = UILabel()
        label.title = titleLabel+":"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    
    override func commonInit() {

        self.addSubview(titleLabel)
        self.addSubview(vinLabel)
        self.addSubview(locationLabel)
        self.addSubview(factoryLabel)
        self.addSubview(bornLabel)
        self.addSubview(carModeLabel)
        self.addSubview(plateLabel)
        self.addSubview(priceLabel)
        
        super.commonInit()
    }

    override func updateConstraints() {

        if self.didSetupConstraints == false {

            let leftPadding:CGFloat = 20
            self.titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(leftPadding)
                make.top.equalTo(self).offset(10)
                make.width.equalTo(self).multipliedBy(0.8)
                make.height.equalTo(20)
            }

            let whiteView = UIView.color(with: .black)
            self.addSubview(whiteView)

            whiteView.snp.makeConstraints { (make) in
                make.width.equalTo(4)
                make.top.equalTo(self.titleLabel)
                make.bottom.equalTo(self.vinLabel).offset(-5)
                make.left.equalTo(self).offset(leftPadding/2-1)
            }

            self.vinLabel.snp.makeConstraints { (make) in
                make.left.equalTo(titleLabel).offset(5)
                make.top.equalTo(titleLabel.snp.bottom).offset(5)
                make.width.equalTo(self).multipliedBy(0.7)
                make.height.equalTo(20)
            }

            let list = [self.locationLabel,self.factoryLabel,
                        self.bornLabel,self.carModeLabel,self.plateLabel,self.priceLabel]

            var topView:UIView?

            for view in list {
                view.snp.makeConstraints({ (make) in
                    make.left.right.equalTo(self.vinLabel)
                    make.height.equalTo(20)

                    if (topView == nil){
                        make.top.equalTo(self.vinLabel.snp.bottom).offset(10)
                    }else{
                        make.top.equalTo(topView!.snp.bottom).offset(5)
                    }
                })

                topView = view
            }

            self.didSetupConstraints = true
        }

        super.updateConstraints()
    }

    deinit {
        print("deinit \(self)")
    }
}
