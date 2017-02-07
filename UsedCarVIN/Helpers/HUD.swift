//
//  HUD.swift
//  carrier
//
//  Created by wang yongchao on 16/8/1.
//  Copyright © 2016 Daimler. All rights reserved.
//

import Foundation
import SVProgressHUD

class HUD: NSObject {
    
    class func initComponent() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMinimumDismissTimeInterval(2)
        SVProgressHUD.setDefaultMaskType(.black)
    }
    
    class func showWaiting(){
        SVProgressHUD.show()
    }
    class func hideWaiting(){
        SVProgressHUD.dismiss()
    }
    
    class func showMsg(message:String) {
        SVProgressHUD.showInfo(withStatus: message)
    }
    
    class func showSuccessMsg(message:String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }
    
    class func showErrorMsg(message:String) {
        SVProgressHUD.showError(withStatus: message)
    }
    
    class func showError(error:NSError?) {
        
        guard let message = error?.domain else {
            SVProgressHUD.dismiss();
            return
        }
        showErrorMsg(message: message)
    }
    
}
