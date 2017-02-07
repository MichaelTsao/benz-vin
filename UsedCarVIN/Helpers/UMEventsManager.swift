//
//  UMEventsManager.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/27.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

struct UMEventsManager {
    enum Events:String {
        //Lincense Plate
        case licenseScanSuccess   = "license_scan_success"
        case licenseCamera        = "use_license_camera"
        case licenseSearch        = "use_license_search"
        //VIN
        case vinScanSuccess       = "vin_scan_success"
        case vinCamera            = "use_vin_camera"
        case vinSearch            = "use_vin_search"

        case showVehicleAllDetail = "show_vehicle_all_detail"
        case tapReportTab         = "tap_report_tab"
        case tapVINTab            = "tap_vin_tab"

        func count() {

            print("UMEvents.\(self.rawValue).count")
            MobClick.event(self.rawValue)
        }
    }
}
