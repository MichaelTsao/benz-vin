//
//  UITextField+Validation.swift
//  UsedCar
//
//  Created by wang yongchao on 30/11/2016.
//  Copyright © 2016 Daimler. All rights reserved.
//

import Foundation
import ObjectiveC

extension UITextField:ValidationProtocol {
    
    enum RuntimeKey {
        static var staticKey = UUID.init().uuidString
    }
    
    var validationArray:[Validation]{
        set{
            objc_setAssociatedObject(self, &UITextField.RuntimeKey.staticKey, newValue,.OBJC_ASSOCIATION_RETAIN)
        }
        get{
            var vArray = objc_getAssociatedObject(self, &UITextField.RuntimeKey.staticKey) as? [Validation]
            
            if vArray == nil {
                vArray = []
                self.validationArray = vArray!
            }
            
            return vArray!
        }
    }
    
    func addValidation(validate:Validation){
        
        self.validationArray.append(validate)
    }

    @discardableResult
    func validate() throws -> Bool {
        
        for validation in self.validationArray {
            let _ = try validation.validate(content: self.text)
        }
        
        return true
    }
}
