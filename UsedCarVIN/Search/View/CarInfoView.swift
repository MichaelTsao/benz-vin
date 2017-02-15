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
    
    
    let carModelsTitleLabel:UILabel = {
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.title = ""
        label.textColor = UIColor.circular_label_text_color

        return label
    }()
    
    lazy var productLabelTip:UILabel    = CarInfoView.initLabelTip(titleLabel:"年款")
    lazy var ProductLabel:UILabel       = CarInfoView.initLabel(titleLabel:"")
    
    lazy var productAreaLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"生产方式")
    lazy var productAreaLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")
    
    
    lazy var registrationDateLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"上牌日期")
    lazy var registrationDateLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")

    
    lazy var usedCarLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"过户")
    lazy var usedCarLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")
    
    
    lazy var priceNewCarLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"新车指导价")
    lazy var priceNewCarLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")
    
    lazy var priceNowLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"二手车市场均价")
    lazy var priceNowLabel:UILabel        = CarInfoView.initLabel(titleLabel:"")
    

    lazy var ageLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"车龄")
    lazy var ageLabel:UILabel        = CarInfoView.initLabelBlue(titleLabel:"")
    
    lazy var milesLabelTip:UILabel        = CarInfoView.initLabelTip(titleLabel:"里程")
    lazy var milesLabel:UILabel        = CarInfoView.initLabelBlue(titleLabel:"")
    
    var bgViewTop:UIView = UIView(frame: CGRect(
        origin: CGPoint(x: 10, y: 10),
        size: CGSize(width: 340, height: 220)))

    var bgView:UIView = BGView(frame: CGRect(
        origin: CGPoint(x: 10, y: 10),
        size: CGSize(width: 340, height: 220)))

    
    lazy var normalRepair:UILabel        = CarInfoView.initLabelTip(titleLabel:"一般修理    ")
    lazy var penqi:UILabel        = CarInfoView.initLabelTip(titleLabel:"喷漆修理    ")
    lazy var banjin:UILabel        = CarInfoView.initLabelTip(titleLabel:"钣金修理    ")
    lazy var suopei:UILabel        = CarInfoView.initLabelTip(titleLabel:"索赔工作    ")

    
    let gotoImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "goto"))
    

    
    var bgViewTowTop:UIView = UIView(frame: CGRect(
        origin: CGPoint(x: 10, y: 10),
        size: CGSize(width: 340, height: 220)))
    
    var bgViewTow:UIView = BGView(frame: CGRect(
        origin: CGPoint(x: 10, y: 10),
        size: CGSize(width: 340, height: 220)))

    lazy var baoyang:UILabel        = CarInfoView.initLabelTip(titleLabel:"最近保养日期 ")
    lazy var licheng:UILabel        = CarInfoView.initLabelTip(titleLabel:"平均间隔里程 ")
    
    let circle:UILabel = {
        let view  = UILabel()//frame:CGRect(x: 0.0, y: 0.0, width: 90.0, height: .0)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 45
        view.backgroundColor = UIColor.circular_label_text_color
        view.clipsToBounds = true
        view.textColor = UIColor.white
        view.textAlignment = NSTextAlignment.center
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 18)
        view.title = ""//5次\n维修

        return view
    }()
    
    
    let circleTwo:UILabel = {
        let view  = UILabel()//frame:CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 45
        view.backgroundColor = UIColor.circular_label_text_color
        view.clipsToBounds = true
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 18)
        view.textAlignment = NSTextAlignment.center
        view.numberOfLines = 0
        view.title = ""//2次\n保养
        
        return view
    }()
    
    class func initLabelTip(titleLabel:String = "") -> UILabel {
        let label = UILabel()
        label.title = titleLabel
        label.textColor = UIColor.label_tip_color
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    
    class func initLabel(titleLabel:String = "") -> UILabel {
        let label = UILabel()
        label.title = ""
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    
    class func initLabelBlue(titleLabel:String = "") -> UILabel {
        let label = UILabel()
        label.title = ""
        label.textColor = UIColor.circular_label_text_color
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    
    var bgViewBottom:UIView = UIView(frame: CGRect(
        origin: CGPoint(x: 10, y: 10),
        size: CGSize(width: 340, height: 220)))
    
    override func commonInit() {
        
        self.backgroundColor = UIColor.back_background
        
        self.addSubview(carModelsTitleLabel)
        
        self.addSubview(productLabelTip)
        self.addSubview(ProductLabel)
        
        self.addSubview(productAreaLabelTip)
        self.addSubview(productAreaLabel)
        
        self.addSubview(registrationDateLabelTip)
        self.addSubview(registrationDateLabel)
        
        self.addSubview(usedCarLabelTip)
        self.addSubview(usedCarLabel)
        
        
        self.addSubview(priceNewCarLabelTip)
        self.addSubview(priceNewCarLabel)
        
        self.addSubview(priceNowLabelTip)
        self.addSubview(priceNowLabel)
        
        self.addSubview(ageLabelTip)
        self.addSubview(ageLabel)
        
        self.addSubview(milesLabelTip)
        self.addSubview(milesLabel)
        
        self.addSubview(bgViewTop)
        bgViewTop.backgroundColor = UIColor.init(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0)

        self.addSubview(bgView)
        
        bgView.addSubview(circle)
        
        self.addSubview(normalRepair)
        normalRepair.textColor = UIColor.white
        self.addSubview(penqi)
        penqi.textColor = UIColor.white
        self.addSubview(banjin)
        banjin.textColor = UIColor.white
        self.addSubview(suopei)
        suopei.textColor = UIColor.white
        
        
        self.addSubview(bgViewTowTop)
        bgViewTowTop.backgroundColor = UIColor.init(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0)
        
        
        self.addSubview(bgViewTow)
        
        self.addSubview(gotoImageView)

        
        bgViewTow.addSubview(circleTwo)
        
        self.addSubview(baoyang)
        baoyang.textColor = UIColor.white
        self.addSubview(licheng)
        licheng.textColor = UIColor.white
        
        titleLabel.textAlignment = .center

        self.addSubview(bgViewBottom)
        bgViewBottom.backgroundColor = UIColor.init(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0)
        
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
            
            self.carModelsTitleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(superview).offset(vPaddingC)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth+200)
            }
            
            self.productLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(carModelsTitleLabel.snp.bottom).offset(vPaddingC)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.ProductLabel.snp.makeConstraints { (make) in
                make.left.equalTo(productLabelTip)
                make.top.equalTo(productLabelTip.snp.bottom).offset(vPaddingB)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.productAreaLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(productLabelTip.snp.right).offset(leftPadding)
                make.top.equalTo(productLabelTip.snp.top)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.productAreaLabel.snp.makeConstraints { (make) in
                make.left.equalTo(productAreaLabelTip)
                make.right.equalTo(productAreaLabelTip)
                make.top.equalTo(productAreaLabelTip.snp.bottom).offset(vPaddingB)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            // 上牌日期，生产年份
            self.registrationDateLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(productAreaLabel.snp.bottom).offset(vPaddingC)
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
            
            
            self.usedCarLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(registrationDateLabelTip.snp.right).offset(leftPadding)
                make.top.equalTo(registrationDateLabelTip)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.usedCarLabel.snp.makeConstraints { (make) in
                make.left.equalTo(usedCarLabelTip)
                make.right.equalTo(usedCarLabelTip)
                make.top.equalTo(registrationDateLabel)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            // 在质保期，过户
            self.priceNewCarLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(usedCarLabel.snp.bottom).offset(vPaddingC)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.priceNewCarLabel.snp.makeConstraints { (make) in
                make.left.equalTo(priceNewCarLabelTip)
                make.top.equalTo(priceNewCarLabelTip.snp.bottom).offset(vPaddingB)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.priceNowLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(priceNewCarLabelTip.snp.right).offset(leftPadding)
                make.top.equalTo(priceNewCarLabelTip)
                make.height.equalTo(labelTipHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.priceNowLabel.snp.makeConstraints { (make) in
                make.left.equalTo(priceNowLabelTip)
                make.top.equalTo(priceNewCarLabel)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            
            // 车龄、公里数
            self.ageLabelTip.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(priceNowLabel.snp.bottom).offset(vPaddingC)
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
            
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            
            self.bgViewTop.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.top.equalTo(milesLabel.snp.bottom).offset(10)
                make.height.equalTo(20)
                make.width.equalTo(screenWidth)
            }

            self.bgView.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.top.equalTo(bgViewTop.snp.bottom).offset(0)
                make.height.equalTo(150)
                make.width.equalTo(screenWidth)
            }

            
            self.circle.snp.makeConstraints { (make) in
                make.left.equalTo(bgView).offset(20)
                make.centerY.equalTo(bgView)
                make.height.equalTo(90)
                make.width.equalTo(90)
            }
            
            self.normalRepair.snp.makeConstraints { (make) in
                make.left.equalTo(150)
                make.top.equalTo(bgView.snp.top).offset(vPaddingC)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
 
            self.penqi.snp.makeConstraints { (make) in
                make.left.equalTo(normalRepair)
                make.top.equalTo(normalRepair.snp.bottom).offset(vPaddingC)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.banjin.snp.makeConstraints { (make) in
                make.left.equalTo(normalRepair)
                make.top.equalTo(penqi.snp.bottom).offset(vPaddingC)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }
            
            self.suopei.snp.makeConstraints { (make) in
                make.left.equalTo(normalRepair)
                make.top.equalTo(banjin.snp.bottom).offset(vPaddingC)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth)
            }

            self.bgViewTowTop.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.top.equalTo(bgView.snp.bottom).offset(0)
                make.height.equalTo(5)
                make.width.equalTo(screenWidth)
            }

            self.gotoImageView.snp.makeConstraints { (make) in
                make.right.equalTo(bgViewTowTop).offset(10)
                make.centerY.equalTo(bgViewTowTop)
                make.height.equalTo(40)
                make.width.equalTo(40)
            }
            
            self.bgViewTow.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.top.equalTo(bgViewTowTop.snp.bottom).offset(0)
                make.height.equalTo(120)
                make.width.equalTo(screenWidth)
            }

            
            self.bgViewBottom.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.top.equalTo(bgViewTow.snp.bottom).offset(0)
                make.height.equalTo(100)
                make.width.equalTo(screenWidth)
            }
            
            self.circleTwo.snp.makeConstraints { (make) in
                make.left.equalTo(bgViewTow).offset(20)
                make.centerY.equalTo(bgViewTow)
                make.height.equalTo(90)
                make.width.equalTo(90)
            }
            
            self.baoyang.snp.makeConstraints { (make) in
                make.left.equalTo(normalRepair)
                make.top.equalTo(bgViewTow.snp.centerY).offset(-30)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth+100)
            }
            
            self.licheng.snp.makeConstraints { (make) in
                make.left.equalTo(normalRepair)
                make.top.equalTo(bgViewTow.snp.centerY).offset(10)
                make.height.equalTo(labelHeight)
                make.width.equalTo(labelwidth + CGFloat(50))
            }
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    deinit {
        print("deinit \(self)")
    }
}
