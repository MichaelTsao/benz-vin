//
//  ReportTableViewCell.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class ReportTableViewCell: BaseTableViewCell,UITableViewCellHeightProtocol {

    let bgView:UIImageView = {

        let image     = UIImage(named: "background_report")
        let imageView = UIImageView(image: image)
        return imageView
    }()

    let titleLabel:UILabel = {

        let label = UILabel()
        label.textColor = UIColor.black
        label.font      = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let dateLabel:UILabel = {

        let label = UILabel()
        label.textColor     = UIColor.lightGray
        label.font          = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()

    let contentLabel:UILabel = {

        let label = UILabel()
        label.textColor     = UIColor.black
        label.font          = UIFont.systemFont(ofSize: 18)
        return label
    }()

    let vinLabel:UILabel = {

        let label = UILabel()
        label.textColor     = UIColor.white
        label.font          = UIFont.systemFont(ofSize: 15)
        return label
    }()

    override func commonInit() {
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(bgView)

        self.vinLabel.title = "VIN:"

        bgView.addSubview(titleLabel)
        bgView.addSubview(dateLabel)
        bgView.addSubview(contentLabel)
        bgView.addSubview(vinLabel)

        bgView.snp.makeConstraints { (make) in
            make.size.equalTo(bgView.image!.size)
            make.center.equalTo(self)
        }

        let padding:CGFloat     = 20
        let labelHeight:CGFloat = 20

        let topPadding:CGFloat = 8
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.top.equalTo(bgView).offset(topPadding)
            make.width.equalTo(bgView).multipliedBy(0.6)
            make.height.equalTo(labelHeight)
        }


        dateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(bgView).offset(-padding)
            make.top.equalTo(bgView).offset(topPadding)
            make.width.equalTo(bgView).multipliedBy(0.3)
            make.height.equalTo(labelHeight)
        }

        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.centerY.equalTo(bgView).offset(-7)
            make.width.equalTo(bgView).multipliedBy(0.8)
        }

        vinLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(padding)
            make.bottom.equalTo(bgView).offset(-22)
            make.width.equalTo(bgView).multipliedBy(0.7)
        }
    }

    static func cellHeight() -> CGFloat {
        return 140
    }
}
