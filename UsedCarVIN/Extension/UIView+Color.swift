//
//  UIView+UIColor.swift
//  TurfPro
//
//  Created by aquilx on 2016/12/11.
//  Copyright © 2016年 Stevens Water. All rights reserved.
//

import UIKit

extension UIView {
    static func color(with color:UIColor) -> UIView {
        
        let view = UIView()

        view.backgroundColor = color
        
        return view
    }
}
