//
//  RecordHeaderView.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class RecordHeaderView: UIView {

    let title:UILabel = {
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInt()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func commonInt() {

        let color = UIColor.init("#BFBFBF")

        let leftLine  = UIView.color(with: color)
        let rightLine = UIView.color(with: color)

        self.addSubview(leftLine)
        self.addSubview(rightLine)
        self.addSubview(title)

        title.textAlignment   = .center
        title.textColor       = color
        title.backgroundColor = UIColor.table_background
        self.backgroundColor  = UIColor.table_background

        let padding:CGFloat = 10

        leftLine.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(padding)
            make.right.equalTo(title)
            make.centerY.equalTo(self)
            make.height.equalTo(1)
        }

        rightLine.snp.makeConstraints { (make) in
            make.left.equalTo(title).offset(padding)
            make.right.equalTo(self).offset(-padding)
            make.centerY.equalTo(self)
            make.height.equalTo(1)
        }

        title.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 90, height: 20))
            make.center.equalTo(self)
        }
    }
}
