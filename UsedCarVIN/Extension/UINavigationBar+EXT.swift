//
//  UINavigationBar+EXT.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func hiddenBottomLine() {
        self.findHairlineImageViewUnder(searchView: self)?.isHidden = true
    }

    func findHairlineImageViewUnder(searchView:UIView) -> UIImageView? {
        if searchView.isKind(of: UIImageView.classForCoder()) && searchView.bounds.size.height <= 1.0 {
            return searchView as? UIImageView
        }

        for subview in searchView.subviews {
            let imageView = self.findHairlineImageViewUnder(searchView: subview)

            if imageView != nil {
                return imageView
            }
        }

        return nil
    }
}
