//
//  UIBarButtonItem+EXT.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/19.
//  Copyright © 2016年 daimler. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {

    class func whiteBackButton() -> UIBarButtonItem? {

        let button              = UIButton(type: .custom)
        button.frame            = CGRect(x: 0, y: 0, width: 60, height: 40)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.imageEdgeInsets  = UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)

        button.setImage(UIImage(named: "icon_back_white"), for: .normal)
        button.setTitle("返回", for: .normal)

        return UIBarButtonItem(customView: button)
    }
}
