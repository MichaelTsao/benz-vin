//
//  BaseTableViewCell.swift
//  myTransport
//
//  Created by wang yongchao on 21/10/2016.
//  Copyright © 2016 Daimler. All rights reserved.
//

import UIKit

protocol UITableViewCellHeightProtocol
{
    static func cellHeight() -> CGFloat
}

class BaseTableViewCell: UITableViewCell {

    var didSetupConstraints = false

    static var reuseIdentifierString:String!{
        get{
            let s_reuseIdentifier:String = String(describing: self)
            
            return s_reuseIdentifier
        }
    }
    
    // MARK: - Initialization Method(s)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func commonInit() {
        self.updateConstraintsIfNeeded()
    }

    override func updateConstraints() {
        super.updateConstraints()
    }
}
