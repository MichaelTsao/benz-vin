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
//        let color:UIColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.00)
        let color:UIColor = UIColor(red: 41.0/255, green: 47.0/255, blue: 54.0/255, alpha: 1.00)

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
    
    
    let dateLabel:UILabel = {
        
        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let mileLabel:UILabel = {
        
        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .right
        return label
    }()

    
    let typeNameLabel:UILabel = {
        
        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    let typeLabel:UILabel = {
        
        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    let descNameLabel:UILabel = {
        
        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    let descLabel:UITextView = {
        let label = UITextView()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font      = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.isEditable = false;
        label.textContainer.maximumNumberOfLines = 7
        label.textContainer.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()


    override func commonInit() {

        self.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.00)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        bgView = BGView(frame: CGRect(
            origin: CGPoint(x: 10, y: 10),
            size: CGSize(width: screenWidth - 20, height: ReportTableViewCell.cellHeight() - 20)))
        self.contentView.addSubview(bgView)
        
//        typeNameLabel.text = "类型:";
//        descNameLabel.text = "说明:";
        
        let str1 = NSMutableAttributedString(string: "类型:")
        let range1 = NSRange(location: 0, length: str1.length)
        let number = NSNumber(value:NSUnderlineStyle.styleSingle.rawValue)//此处需要转换为NSNumber 不然不对,rawValue转换为integer
        str1.addAttribute(NSUnderlineStyleAttributeName, value: number, range: range1)
        str1.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: range1)
        typeNameLabel.attributedText = str1
        
        let str2 = NSMutableAttributedString(string: "说明:")
        let range2 = NSRange(location: 0, length: str1.length)
        let number2 = NSNumber(value:NSUnderlineStyle.styleSingle.rawValue)//此处需要转换为NSNumber 不然不对,rawValue转换为integer
        str2.addAttribute(NSUnderlineStyleAttributeName, value: number2, range: range2)
        str2.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: range2)
        descNameLabel.attributedText = str2
        
        bgView.addSubview(typeNameTitleLabel)
        bgView.addSubview(dateLabel)
        bgView.addSubview(mileLabel)
        bgView.addSubview(typeNameLabel)
        bgView.addSubview(typeLabel)
        bgView.addSubview(descNameLabel)
        bgView.addSubview(descLabel)
        
        let padding:CGFloat     = 20
        let labelHeight:CGFloat = 20
        let topPadding:CGFloat = 8
        
        typeNameTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(5)
            make.top.equalTo(bgView).offset(-5)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding+50)
            make.top.equalTo(bgView).offset(topPadding)
            make.width.equalTo(bgView.bounds.size.width-((padding+50)*2))
            make.height.equalTo(labelHeight)
        }
        
        mileLabel.snp.makeConstraints { (make) in
            make.right.equalTo(bgView).offset(-10)
            make.top.equalTo(bgView).offset(topPadding)
            make.width.equalTo(bgView).multipliedBy(0.3)
            make.height.equalTo(labelHeight)
        }
        
        typeNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.top.equalTo(mileLabel).offset(padding+10)
            make.right.equalTo(bgView).offset(-padding)
            make.height.equalTo(labelHeight)
        }
        
        typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.top.equalTo(typeNameLabel).offset(padding)
            make.right.equalTo(bgView).offset(-padding)
            make.height.equalTo(labelHeight)
        }
        
        let line:CGFloat = 10;
        
        descNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.top.equalTo(typeLabel).offset(padding+10)
            make.width.equalTo(bgView).offset(2*padding)
            make.height.equalTo(labelHeight)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding-5)
            make.top.equalTo(descNameLabel).offset(padding)
            make.right.equalTo(bgView).offset(-padding+5)
            make.height.equalTo(labelHeight * line)
        }
        
    }

    static func cellHeight() -> CGFloat {
        return 280
    }
}
