//
//  NoDelaysScrollView.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/23.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class NoDelaysScrollView: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delaysContentTouches    = false
        self.canCancelContentTouches = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view.isKind(of: (self.classForCoder)){
            return true
        }

        return super.touchesShouldCancel(in: view)
    }

    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {

        if(view.isKind(of: UIButton.classForCoder())) {
            return true
        }

        return false
    }
}
