//
//  PlateInfoReader.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/26.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit
import CHCSVParser

class PlateInfoReader: NSObject {
    class var shared:PlateInfoReader
    {
        struct Static {
            static let onceToken  = NSUUID().uuidString
            static var instance   : PlateInfoReader? = nil
        }

        DispatchQueue.once(token: Static.onceToken) {
            Static.instance = PlateInfoReader()
        }

        return Static.instance!
    }

    let daimlerPlates:[String:DaimlerPlateModel]? = {
        return PlateInfoReader.read()
    }()

    static func read() -> [String:DaimlerPlateModel]? {

        let url = Bundle.main.url(forResource: "plate", withExtension: "csv")
        let delimiter:unichar  = ",".utf16.first!

        guard let results: [[String]] = NSArray(contentsOfDelimitedURL: url, options:[], delimiter: delimiter) as? [[String]] else {
            return nil;
        }

        var models = [String:DaimlerPlateModel]()
        for row in results {

            if  row.count > 3 {
                let model              = DaimlerPlateModel()
                model.vin              = row[0]
                model.plate            = row[1]
                model.modeCode         = row[2]
                model.franModelVariant = row[3]
                models[model.plate!]   = model
            }
            print(row)
          //print("column1: \( model.vin),column2: \( model.modeCode), column3: \(  model.franModelVariant)")
        }

        return models
    }
}
