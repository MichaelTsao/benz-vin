//
//  DetailTableViewCell.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/26.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit
import SnapKit

class DetailTableViewCell: BaseTableViewCell,UITableViewCellHeightProtocol {

    private let contextLabel:UILabel = {
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    var title:String = "" {
        willSet{
            guard newValue.characters.count > 0 else {
                self.contextLabel.text = ""
                return
            }

            self.contextLabel.title = newValue + ":"
        }
        didSet{
            self.updateTitleWidth()
        }
    }
    var value:String = "" {
        willSet{
            self.contextLabel.value = newValue
        }
        didSet{
            self.updateTitleWidth()
        }
    }

    var isSection:Bool = false {
        willSet{
            self.contextLabel.backgroundColor = newValue ? UIColor.black : UIColor.white
            self.contextLabel.textColor       = newValue ? UIColor.white : UIColor.black
        }
    }

    func updateTitleWidth() {
        let size = self.contextLabel.text?.size(with: self.contextLabel.font, size: CGSize(width:0, height: 20))

        if let size = size {
            self.contextLabel.snp.remakeConstraints({ (make) in
                make.centerY.equalTo(self.contentView)
                make.height.equalTo(20)
                make.left.equalTo(self.contentView).offset(20)
                make.width.equalTo(size.width + 10)
            })
        }
    }

    override func commonInit() {
        self.contentView.addSubview(self.contextLabel)

        super.commonInit()
    }

    override func updateConstraints() {
        if didSetupConstraints == false {

            self.contextLabel.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView)
                make.height.equalTo(20)
                make.left.equalTo(self.contentView).offset(20)
                make.width.equalTo(self).multipliedBy(80)
            })

            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    static func cellHeight() -> CGFloat {
        return 25
    }
}
