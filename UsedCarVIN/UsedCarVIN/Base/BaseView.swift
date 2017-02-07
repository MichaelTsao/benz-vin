//
//  BaseView.swift
//  myTransport
//
//  Created by wang yongchao on 21/10/2016.
//  Copyright © 2016 Daimler. All rights reserved.
//

import UIKit

class BaseView: UIView {

    // MARK: - Initialization Method(s)

    var didSetupConstraints = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
      self.updateConstraintsIfNeeded()
    }

    override func updateConstraints() {
        super.updateConstraints()
    }
}

