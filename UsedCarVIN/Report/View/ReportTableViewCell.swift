//
//  ReportTableViewCell.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class BGView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func draw(_ rect: CGRect) {
//        let h = rect.height
//        let w = rect.width
        let color:UIColor = UIColor(red: 55.00/255, green: 62.00/255, blue: 70.00/255, alpha: 1.00)
        
//        let drect = CGRect(x: (w * 0.25),y: (h * 0.25),width: (w * 0.5),height: (h * 0.5))
        let bpath:UIBezierPath = UIBezierPath(rect: rect)
        color.setFill()
        bpath.fill()
        
        color.set()
        bpath.stroke()
        
        NSLog("drawRect has updated the view")
    }
}

class ReportTableViewCell: BaseTableViewCell,UITableViewCellHeightProtocol {

    var bgView:UIView = BGView(frame: CGRect(
        origin: CGPoint(x: 10, y: 10),
        size: CGSize(width: 340, height: 220)))
    
    
    
    
    let typeNameTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor     = UIColor.circular_label_text_color
        label.font          = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    

    let descLabel:UILabel = {

        let label = UILabel()
        label.textColor = UIColor.white
        label.font      = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()

    let dateLabel:UILabel = {

        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()

    let mileLabel:UILabel = {
        
        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .right
        return label
    }()
    
    let typeLabel:UILabel = {
        
        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    let contentLabel:UILabel = {

        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 18)
        return label
    }()

//    let sanLabel:UILabel = {
//
//        let label = UILabel()
//        label.textColor     = UIColor.white
//        label.font          = UIFont.systemFont(ofSize: 18)
//        return label
//    }()

    override func commonInit() {
        self.backgroundColor = UIColor(red: 41.0/255, green: 47.0/255, blue: 54.0/255, alpha: 1.00)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        bgView = BGView(frame: CGRect(
            origin: CGPoint(x: 10, y: 10),
            size: CGSize(width: screenWidth - 20, height: ReportTableViewCell.cellHeight() - 20)))
        self.contentView.addSubview(bgView)

//        self.sanLabel.title = "操作人员:"

        
        

        
        let typeNameLabel:UILabel = {
            
            let label = UILabel()
            label.textColor     = UIColor.white
            label.font          = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .left
            return label
        }()
        typeNameLabel.text = "类型:";
        
        let descNameLabel:UILabel = {
            
            let label = UILabel()
            label.textColor     = UIColor.white
            label.font          = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .left
            return label
        }()
        descNameLabel.text = "维修说明:";
        
        
        
        bgView.addSubview(typeNameTitleLabel)
        bgView.addSubview(typeNameLabel)
        bgView.addSubview(descNameLabel)
        bgView.addSubview(descLabel)
        bgView.addSubview(typeLabel)
        bgView.addSubview(dateLabel)
        bgView.addSubview(mileLabel)
//        bgView.addSubview(contentLabel)
//        bgView.addSubview(sanLabel)

//        bgView.snp.makeConstraints { (make) in
//            make.size.equalTo(bgView.image!.size)
//            make.center.equalTo(self)
//        }

        let padding:CGFloat     = 20
        let labelHeight:CGFloat = 20
        let topPadding:CGFloat = 8
        
        
        
        typeNameTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(0)
            make.top.equalTo(bgView).offset(-5)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        typeNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.top.equalTo(bgView).offset(40)
            make.width.equalTo(bgView).multipliedBy(0.8)
            make.height.equalTo(labelHeight)
        }

        typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.top.equalTo(bgView).offset(70)
            make.width.equalTo(bgView).multipliedBy(0.8)
            make.height.equalTo(labelHeight)
        }
        
        let line:CGFloat = 6;
        descNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.top.equalTo(bgView).offset(ReportTableViewCell.cellHeight() - padding - labelHeight * line - CGFloat(20.0))
            make.width.equalTo(bgView).multipliedBy(0.8)
            make.height.equalTo(labelHeight)
        }
        
        descLabel.numberOfLines = 0
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.top.equalTo(bgView).offset(ReportTableViewCell.cellHeight() - padding - labelHeight * line)
            make.width.equalTo(bgView).multipliedBy(0.9)
            make.height.equalTo(labelHeight * line)
        }

        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding+50)
            make.top.equalTo(bgView).offset(topPadding)
            make.width.equalTo(bgView).multipliedBy(0.3)
            make.height.equalTo(labelHeight)
        }

        mileLabel.snp.makeConstraints { (make) in
            make.right.equalTo(bgView).offset(-padding)
            make.top.equalTo(bgView).offset(topPadding)
            make.width.equalTo(bgView).multipliedBy(0.3)
            make.height.equalTo(labelHeight)
        }
        
//        contentLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(bgView).offset(padding)
//            make.centerY.equalTo(bgView).offset(-7)
//            make.width.equalTo(bgView).multipliedBy(0.8)
//        }

//        sanLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(bgView).offset(padding)
//            make.top.equalTo(bgView).offset(100)
//            make.width.equalTo(bgView).multipliedBy(0.7)
//        }
    }

    static func cellHeight() -> CGFloat {
        return 280
    }
}
