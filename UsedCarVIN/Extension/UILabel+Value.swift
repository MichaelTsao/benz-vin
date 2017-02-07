
//
//  UILabel+Value.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

extension UILabel {

    enum RuntimeKey {
        static var staticTitleKey = UUID.init().uuidString
        static var staticValueKey = UUID.init().uuidString
    }

    var title:String? {
        set{
            objc_setAssociatedObject(self, &UILabel.RuntimeKey.staticTitleKey, newValue,.OBJC_ASSOCIATION_RETAIN)

            self.refreshText()
        }
        get{
            return objc_getAssociatedObject(self, &UILabel.RuntimeKey.staticTitleKey) as? String
        }
    }

    var value:String? {
        set{
            objc_setAssociatedObject(self, &UILabel.RuntimeKey.staticValueKey, newValue,.OBJC_ASSOCIATION_RETAIN)

            self.refreshText()
        }
        get{
            return objc_getAssociatedObject(self, &UILabel.RuntimeKey.staticValueKey) as? String
        }
    }

    private func refreshText(){
        self.text = (self.title ?? "") + (self.value ?? "")
    }
}
