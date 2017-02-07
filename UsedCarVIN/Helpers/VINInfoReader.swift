//
//  VINInfoReader.swift
//  UsedCarVIN
//
//  Created by huiguan on 12/21/16.
//  Copyright © 2016 daimler. All rights reserved.
//

import Foundation
import CHCSVParser

class VINInfoReader{

    class var shared:VINInfoReader
    {
        struct Static {
            static let onceToken  = NSUUID().uuidString
            static var instance   : VINInfoReader? = nil
        }

        DispatchQueue.once(token: Static.onceToken) {
            Static.instance = VINInfoReader()
        }

        return Static.instance!
    }

    let daimlerVINs:[DaimlerVINModel] = {
        return VINInfoReader.read()
    }()
    
    static func read() -> [DaimlerVINModel] {
        let url = Bundle.main.url(forResource: "vin", withExtension: "csv")
        let delimiter:unichar  = ",".utf16.first!
        guard let results: [[String]] = NSArray(contentsOfDelimitedURL: url, options:[], delimiter: delimiter) as? [[String]] else {
            return [];
        }
        
        var models = [DaimlerVINModel]()
        for row in results {
            let model = DaimlerVINModel()
            model.vin = row[0]
            model.modeCode = row[1]
            model.franModelVariant = row[2]
            models.append(model)
            //print("column1: \( model.vin),column2: \( model.modeCode), column3: \(  model.franModelVariant)")
        }
        
        return models
    }
    
}
