//
//  Validation.swift
//  UsedCar
//
//  Created by wang yongchao on 29/11/2016.
//  Copyright © 2016 Daimler. All rights reserved.
//

import Foundation

protocol ValidationProtocol
{
   
    func addValidation(validate:Validation)

    @discardableResult
    func validate() throws -> Bool
}

enum Validation {
    case required
    case length(min: Int, max: Int)
    case range (min: Int, max: Int)
    case phoneNumber
    case email
    case vin
    case licensePlate
    
    func validate(content: Any?, domain: String? = nil) throws -> Bool {
        
        guard let content = content else {
            throw(makeError(domain: domain ?? "Null Error"))
        }
        
        switch (self) {
            
        case .required:
            guard let stringContent = content as? String else {
                throw(formatError)
            }
            
            if stringContent.characters.count == 0 {
                throw(makeError(domain: domain ?? "Required field"))
            }
            
            return true
            
        case .length(let min, let max):
            
            guard let stringContent = content as? String else {
                throw(formatError)
            }
            
            if stringContent.characters.count > max ||
                stringContent.characters.count < min {
                
                throw(makeError(domain: domain ?? "Out of Length"))
            }
            
            return true
            
        case .range(let min, let max):
            
            guard let intContent = content as? Int else {
                throw(formatError)
            }
            
            if intContent > max || intContent < min {
                
                throw(makeError(domain: domain ?? "Out of Range"))
            }
            
            return true
            
        case .phoneNumber:
            
            guard let phoneNumber = content as? String else {
                throw(formatError)
            }
            
            let error = makeError(domain:  domain ?? "Wrong PhoneNumber")
            
            if phoneNumber.characters.count == 0 {
                throw(error)
            }
            
            let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
           
            let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
           
            if regexMobile.evaluate(with: phoneNumber) == false {
                
                throw(error)
            }
            
            return true
            
        case .email:
            
            guard let stringContent = content as? String else {
                throw(formatError)
            }
            
            let error = makeError(domain: domain ??  "Wrong Email Address")
            
            if stringContent.characters.count == 0 {
                throw(error)
            }
            
            let email = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            
            let regexEmail = NSPredicate(format: "SELF MATCHES %@",email)
            
            if regexEmail.evaluate(with: stringContent) == false {
                
                throw(error)
            }
            return true

        case .vin:
            guard let stringContent = content as? String else {
                throw(formatError)
            }

            let error = makeError(domain: domain ??  "Wrong Vin Code")

            if stringContent.characters.count == 0 {
                throw(error)
            }

            let vin = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{17,18}$"

            let regex = NSPredicate(format: "SELF MATCHES %@",vin)

            if regex.evaluate(with: stringContent) == false {

                throw(error)
            }
            
            return true

        case .licensePlate:
            guard let stringContent = content as? String else {
                throw(formatError)
            }

            let error = makeError(domain: domain ??  "Wrong Vin Code")

            if stringContent.characters.count == 0 {
                throw(error)
            }

            let licensePlate = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6}$"

            let regex = NSPredicate(format: "SELF MATCHES %@",licensePlate)

            if regex.evaluate(with: stringContent) == false {

                throw(error)
            }
            
            return true
        }
        
    }
}

let formatError = makeError(domain: "Format Error")
private func makeError(domain:String,code:Int = -1,userInfo dict: [AnyHashable : Any]? = nil) ->Error{
    
    return NSError(domain: domain, code: code, userInfo: dict) as Error
}
