//
//  RecordTableViewCell.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class RecordTableViewCell: BaseTableViewCell,UITableViewCellHeightProtocol {

    let bgView:UIImageView = {

        let image     = UIImage(named: "background_record")
        let imageView = UIImageView(image: image)
        return imageView
    }()

    let titleLabel:UILabel = {

        let label = UILabel()
        label.textColor = UIColor.white
        label.font      = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let kmLabel:UILabel = {

        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    let dateLabel:UILabel = {

        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()

    let componentTitleLabel:UILabel = {

        let label = UILabel()
        label.textColor = UIColor.white
        label.font      = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.lightGray
        return label
    }()

    let componentLabel:UILabel = {

        let label = UILabel()
        label.textColor = UIColor.white
        label.font      = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()

    let contentTitleLabel:UILabel = {

        let label = UILabel()
        label.textColor = UIColor.white
        label.font      = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.lightGray
        return label
    }()

    let contentLabel:UILabel = {

        let label = UILabel()
        label.textColor = UIColor.white
        label.font      = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()

    let moreLabel:UILabel = {

        let label = UILabel()
        label.textColor = UIColor.white
        label.font      = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()

    override func commonInit() {

        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(bgView)

        self.componentTitleLabel.text = "内容:"
        self.contentTitleLabel.text   = "详细:"
        self.moreLabel.text           = "查看更多"

        bgView.addSubview(titleLabel)
        bgView.addSubview(kmLabel)
        bgView.addSubview(dateLabel)
        bgView.addSubview(componentTitleLabel)
        bgView.addSubview(componentLabel)
        bgView.addSubview(contentTitleLabel)
        bgView.addSubview(contentLabel)
        bgView.addSubview(moreLabel)

        bgView.snp.makeConstraints { (make) in
            make.size.equalTo(bgView.image!.size)
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }

        let padding:CGFloat     = 10
        let labelHeight:CGFloat = 20

        let topPadding:CGFloat = 8
        let topWidth:CGFloat   = 90
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.top.equalTo(bgView).offset(topPadding)
            make.width.equalTo(topWidth)
            make.height.equalTo(labelHeight)
        }

        kmLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView)
            make.top.equalTo(bgView).offset(topPadding)
            make.width.equalTo(topWidth)
            make.height.equalTo(labelHeight)
        }

        dateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(bgView).offset(-padding)
            make.top.equalTo(bgView).offset(topPadding)
            make.width.equalTo(topWidth)
            make.height.equalTo(labelHeight)
        }

        let contentHeight:CGFloat = 30
        componentTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.centerY.equalTo(bgView).offset(-contentHeight/2)
            make.width.equalTo(50)
            make.height.equalTo(contentHeight)
        }

        componentLabel.snp.makeConstraints { (make) in
            make.right.equalTo(bgView).offset(-padding)
            make.left.equalTo(componentTitleLabel.snp.right).offset(padding)
            make.centerY.equalTo(componentTitleLabel)
            make.height.equalTo(contentHeight)
        }

        contentTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.centerY.equalTo(bgView).offset(contentHeight/2)
            make.width.equalTo(50)
            make.height.equalTo(contentHeight)
        }

        contentLabel.snp.makeConstraints { (make) in
            make.right.equalTo(bgView).offset(-padding)
            make.left.equalTo(contentTitleLabel.snp.right).offset(padding)
            make.centerY.equalTo(contentTitleLabel)
            make.height.equalTo(contentHeight)
        }

        moreLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.bottom.equalTo(bgView).offset(-14)
            make.width.equalTo(bgView).multipliedBy(0.7)
            make.height.equalTo(labelHeight)
        }
    }

    static func cellHeight() -> CGFloat {
        return 170
    }
}
