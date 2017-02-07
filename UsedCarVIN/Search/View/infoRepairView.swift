//
//  infoRepairView.swift
//  UsedCarVIN
//
//  Created by DreamTeamAAn on 2017/2/7.
//  Copyright © 2017年 daimler. All rights reserved.
//

import UIKit

class infoRepairView: BaseView {
    
    
    
    
    
    //42	47	54
    
    let blackTipView:UIView = {
        var view  = UIView()
        view = .color(with: .black)
        return view
    }()
    
    let circularLabel:UILabel = {
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize:20.0)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.circular_label_text_color
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 25.0
        return label
    }()
    
    let titleLabel:UILabel = {
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize:20.0)
        label.textColor = UIColor.title_label_text_color
        return label
    }()
    
    //一般维修
    lazy var carModelsLabelTip:UILabel    = infoRepairView.initLabelTip(titleLabel:"")
    lazy var carModelsLabel:UILabel       = infoRepairView.initLabel(titleLabel:"")
    
    //喷器维修
    lazy var priceLabelTip:UILabel        = infoRepairView.initLabelTip(titleLabel:"")
    lazy var priceLabel:UILabel        = infoRepairView.initLabel(titleLabel:"")
    
    //钣金修理
    lazy var registrationDateLabelTip:UILabel        = infoRepairView.initLabelTip(titleLabel:"")
    lazy var registrationDateLabel:UILabel        = infoRepairView.initLabel(titleLabel:"")
    
    //索赔工作
    lazy var productDateLabelTip:UILabel        = infoRepairView.initLabelTip(titleLabel:"")
    lazy var productDateLabel:UILabel        = infoRepairView.initLabel(titleLabel:"")
    
    
    class func initLabelTip(titleLabel:String = "") -> UILabel {
        let label = UILabel()
        label.title = titleLabel
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    class func initLabel(titleLabel:String = "") -> UILabel {
        let label = UILabel()
        label.title = ""
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    
    override func commonInit() {
        
        self.backgroundColor = UIColor.table_new_background
        
        self.addSubview(blackTipView)
        
        self.addSubview(titleLabel)
        
        self.addSubview(carModelsLabelTip)
        self.addSubview(carModelsLabel)
        
        self.addSubview(priceLabelTip)
        self.addSubview(priceLabel)
        
        self.addSubview(registrationDateLabelTip)
        self.addSubview(registrationDateLabel)
        
        self.addSubview(productDateLabelTip)
        self.addSubview(productDateLabel)
        
        
        titleLabel.textAlignment = .center
        
        
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

            
            self.blackTipView.snp.makeConstraints { (make) in
                make.top.equalTo(0)
                make.left.equalTo(superview)
                make.width.equalTo(superview)
                make.height.equalTo(10)
            }
            
            
            self.titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(superview).offset(leftPadding)
                make.top.equalTo(superview).offset(vPaddingA)
                make.right.equalTo(superview).offset(-leftPadding)
                make.height.equalTo(leftPadding)
            }
            
            
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
            
            
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    deinit {
        print("deinit \(self)")
    }
}
