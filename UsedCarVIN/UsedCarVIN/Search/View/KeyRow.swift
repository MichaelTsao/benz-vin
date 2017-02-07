//
//  KeyRow.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/21.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit
import SwiftyButton

class KeyRow: BaseView {

    static let keyCornerRadius:CGFloat = 5

    var keyStrings:[String]   = []
    var keyButtons:[UIButton] = []

    init(keys:[String]){
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 30))

        keyStrings = keys

        commonInit()
    }
    
    required init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func commonInit() {
        super.commonInit()

        for key in keyStrings {

            let button = SwiftyButton()

            button.cornerRadius     = KeyRow.keyCornerRadius
            button.shadowHeight     = 0

            button.buttonColor      = UIColor.white
            button.highlightedColor = UIColor.black

            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.white, for: .highlighted)

            button.setTitle(key, for: .normal)

            button.titleLabel?.font = UIFont.systemFont(ofSize: 24)

            self.addSubview(button)
        }

        didSetupConstraints = false
        self.updateConstraintsIfNeeded()
    }

    override func updateConstraints() {

        if didSetupConstraints == false {

            let padding:CGFloat = 2
            var left:UIView? = nil
            for button in self.subviews {

                button.snp.makeConstraints({ (make) in

                    if left == nil {
                        make.left.equalTo(self).offset(padding)
                    }else{
                        make.left.equalTo(left!.snp.right).offset(padding)
                        make.width.equalTo(left!)
                    }

                    if button == self.subviews.last! {
                        make.right.equalTo(self).offset(-padding)
                    }

                    make.top.equalTo(self)
                    make.bottom.equalTo(self)
                })

                left = button
            }

            didSetupConstraints = true
        }

        super.updateConstraints()
    }
}
