//
//  SearchBaseViewController.swift
//  UsedCarVIN
//
//  Created by DreamTeamAAn on 2017/2/9.
//  Copyright © 2017年 daimler. All rights reserved.
//

import UIKit

class SearchBaseViewController: BaseViewController {
    
    var vinSharedManager = VINSharedManager.sharedInstance()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "星睿识别"
        
        self.view.backgroundColor = UIColor.white
        
        self.cameraButtonVin.frame=CGRect(x: 0, y: UIScreen.main.bounds.height/2-180, width: 160, height: 160)
        self.cameraButtonVin.center.x = self.view.center.x
        self.cameraButtonVin.addTarget(self, action: #selector(actionVin), for: .touchUpInside)
        self.view .addSubview(cameraButtonVin)
        
        self.cameraButtonNp.frame=CGRect(x: 0, y: UIScreen.main.bounds.height/2+30, width: 160, height: 160)
        self.cameraButtonNp.addTarget(self, action: #selector(actionNp), for: .touchUpInside)
        self.cameraButtonNp.center.x = self.view.center.x
        self.view .addSubview(cameraButtonNp)
        
        self.cameraButtonHand.frame=CGRect(x: 0, y: UIScreen.main.bounds.size.height-50, width: UIScreen.main.bounds.size.width, height: 50)
        self.cameraButtonHand.addTarget(self, action: #selector(actionHand), for: .touchUpInside)
        self.view .addSubview(cameraButtonHand)
        
        
        let leftImage = UIImage(named:"icon-camera-128")
        let leftImageSize = leftImage?.size
        
        let rightImage = UIImage(named:"icon-camera-128")
        let rightImageSize = rightImage?.size
        
        self.leftNaviItemButton.frame=CGRect(x: 0, y: 0, width: ((leftImageSize?.width)!/2), height: ((leftImageSize?.height)!/2))
        self.rightNaviItemButton.frame=CGRect(x: 0, y: 0, width: ((rightImageSize?.width)!/2), height: ((rightImageSize?.height)!/2))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.leftNaviItemButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightNaviItemButton)
        
    }
    
//    override func setRightBarNavigationItem() {
////        guard let barButtonItem   = UIBarButtonItem.whiteBackButton(),
////            let button:UIButton = barButtonItem.customView as? UIButton else {
////                return
////        }
////
////        let barLeftItemButton = UIBarButtonItem.init()
////        barLeftItemButton.backgroundImage(for: <#T##UIControlState#>, barMetrics: <#T##UIBarMetrics#>)
////        
////        
////        self.navigationItem.leftBarButtonItem = barButtonItem
////        button.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
//        
//        
//
//
//    }
    
    
    
    
    
    
    
    
    
    
    

    func searchDeatilWithVin(vinCode:String){
        
        NSLog("searchDeatil code = \(vinCode)")
        
        let superview = self
        HUD.showWaiting()
        
        let vehicle = VehicleModel()
        NSLog("init VehicleModel")
        
        DispatchQueue.global(qos: .default).async {
            NSLog("set vinCode %@",vinCode)
            
            //先把本地信息覆盖一遍
            superview.vinSharedManager.searchVINInfo(vinCode) { dict in
                NSLog("init VinSharedManager")
                
                if let data = dict as? [String:String] {
                    
                    vehicle.parse(with: data)
                    NSLog("parse vehicle")
                    
                    //需要放在parse下面，不然会数据会被覆盖
                    vehicle.vin = vinCode
                    NSLog("set vin")
                }
            }
            
            
            let path = CARVIN_API_URL+"Vehicle?VIN=\(vinCode)"//
            
            XBNetHandle.getRequestWithUrlStr(urlStr: path, successBlock: { (result) in
                //Data转换成String打印输出
                let str = String(data:result!, encoding:String.Encoding.utf8)
                //输出json字符串
                print("Json Str:");
                print(str ?? "")
                //把NSData对象转换回JSON对象
                let json : AnyObject! = try? JSONSerialization
                    .jsonObject(with: result!, options:JSONSerialization.ReadingOptions.allowFragments) as AnyObject!
                print("Json Object:"); print(json)
                
                let number :Int = json?["resultCode"] as! Int
                
                if (number == 0)
                {
                    print("resultCode->:");
                    print(json)
                    
                    let dataDic = json?["data"] as? NSDictionary
                    
                    print("resultCode-dataDic>:");
                    print(dataDic ?? "")
                    
                    //生成模型 跳转到详情页面
                    //                        let vehicle = VehicleModel()
                    //                        NSLog("init VehicleModel")
                    
                    vehicle.parseJson(orcData: dataDic!)
                    NSLog("parse vehicle")
                    
                    //需要放在parse下面，不然会数据会被覆盖
                    vehicle.vin = vinCode
                    NSLog("set vin")
                    
                    DispatchQueue.main.async {
                        NSLog("show result")
                        HUD.hideWaiting()
//                        superview.delegate?.searchedResult(model: vehicle, searchViewController: superview)
                        
                        let searchResultsVC   = SearchResultsViewController()
                        searchResultsVC.model = vehicle
                        self.navigationController?.pushViewController(searchResultsVC, animated: true)
                        
                    }
                    
                    
                    //                    if let data =
                    
                    
                    
                }else{
                    if let number = json?["message"] as? String {
                        print(number)
                        HUD.showErrorMsg(message: number)
                    }
                    
                }
                //                HUD.hideWaiting()
            }) { (Error) in
                //            code
                print(Error ?? "")
                //                HUD.hideWaiting()
                HUD.showErrorMsg(message: "请求服务器出错")
            }
        }
        
    }
    
    func searchDeatilWithNP(licensePlate:String){
        //生成模型 跳转到详情页面
        let vehicle = VehicleModel()
        vehicle.licensePlate = licensePlate
        
        //解析从牌照查询出来的汽车信息
        //赋值給vehicle 用delegate传递出去
        //将会显示详情页面-SearchResultsViewController
        

        
        let path = CARVIN_API_URL+"Vehicle?regNo=\(licensePlate)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        print("path->:"+path);
        
        XBNetHandle.getRequestWithUrlStr(urlStr: path, successBlock: { (result) in
            //Data转换成String打印输出
            let str = String(data:result!, encoding:String.Encoding.utf8)
            //输出json字符串
            print("Json Str:");
            print(str ?? "")
            //把NSData对象转换回JSON对象
            let json : AnyObject! = try? JSONSerialization
                .jsonObject(with: result!, options:JSONSerialization.ReadingOptions.allowFragments) as AnyObject!
            print("Json Object:"); print(json)
            
            let number :Int = json?["resultCode"] as! Int
            
            if (number == 0)
            {
                print("resultCode->:");
                print(json)
                
                let dataDic = json?["data"] as? NSDictionary
                
                print("resultCode-dataDic>:");
                print(dataDic ?? "")
                
                vehicle.parseJson(orcData: dataDic!)
                NSLog("parse vehicle")
                
                //查询完号牌之后，根据vin覆盖一次
                self.vinSharedManager.searchVINInfo(vehicle.vin) { dict in
                    NSLog("init VinSharedManager")
                    if let data = dict as? [String:String] {
                        vehicle.parse(with: data)
                        NSLog("parse vehicle")
                        
                        HUD.hideWaiting()

                        let searchResultsVC   = SearchResultsViewController()
                        searchResultsVC.model = vehicle
                        self.navigationController?.pushViewController(searchResultsVC, animated: true)
                    }
                }
            }else{
                if let number = json?["message"] as? String {
                    print(number)
                    HUD.showErrorMsg(message: number)
                }
            }

        }) { (Error) in

            print(Error ?? "")
            HUD.showErrorMsg(message: "请求服务器出错")
        }
        
    }
    
    
    
    let leftNaviItemButton:UIButton = {
        let button = UIButton(type: .custom)
        let voiceImage = UIImage(named:"benze")
        button.setImage(voiceImage, for: .normal)
        return button
    }()
    
    
    let rightNaviItemButton:UIButton = {
        let button = UIButton(type: .custom)
        let voiceImage = UIImage(named:"menu-128")
        button.setImage(voiceImage, for: .normal)
        return button
    }()
    
    
    
    
    
    
    
    let cameraButtonVin:UIButton = {
        let button = UIButton(type: .custom)
        let voiceImage = UIImage(named:"icon-camera-128")
        
        
        
        button.backgroundColor = UIColor(red: 55.00/255, green: 62.00/255, blue: 70.00/255, alpha: 1.00)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 80.0
        button.setTitle("VIN识别", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setImage(voiceImage, for: .normal)
//        button.layer.borderWidth = 1.0
//        button.layer.borderColor = UIColor.init(red: 150.0/255, green: 150.0/255, blue: 150.0/255, alpha: 1).cgColor
        
        let voiceImageSize = voiceImage?.size
        button.imageEdgeInsets = UIEdgeInsetsMake(40, (160-(voiceImageSize?.width)!)/2, 160-40-(voiceImageSize?.height)!, (160-(voiceImageSize?.width)!)/2)
        button.titleEdgeInsets = UIEdgeInsetsMake(60, -40, 0, 25)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19.0)
        return button
    }()
    
    
    let cameraButtonNp:UIButton = {
        let button = UIButton(type: .custom)
        let voiceImage = UIImage(named:"icon-camera-128")
        button.backgroundColor = UIColor(red: 55.00/255, green: 62.00/255, blue: 70.00/255, alpha: 1.00)//init(red: 241.0/255, green: 241.0/255, blue: 241.0/255, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 80.0
        button.setTitle("车牌识别", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setImage(voiceImage, for: .normal)
//        button.layer.borderWidth = 1.0
//        button.layer.borderColor = UIColor.init(red: 150.0/255, green: 150.0/255, blue: 150.0/255, alpha: 1).cgColor
        
        let voiceImageSize = voiceImage?.size
        button.imageEdgeInsets = UIEdgeInsetsMake(40, (160-(voiceImageSize?.width)!)/2, 160-40-(voiceImageSize?.height)!, (160-(voiceImageSize?.width)!)/2)
        button.titleEdgeInsets = UIEdgeInsetsMake(60, -40, 0, 25)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19.0)
        return button
    }()
    
    let cameraButtonHand:UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.init(red: 241.0/255, green: 241.0/255, blue: 241.0/255, alpha: 1)
        button.setTitle("手动输入", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19.0)
        return button
    }()
    
    func actionVin() {
        
        print("Navigate to camera view controller");
        HUD.showWaiting()
        let superview = self
        DispatchQueue.global(qos: .default).async {
            let camersVC = CameraViewController()
            camersVC.delegate = superview
            DispatchQueue.main.async {
                superview.present(camersVC, animated: true) {
                    HUD.hideWaiting()
                }
            }
        }
        UMEventsManager.Events.vinCamera.count()
    }
    
    func actionNp() {
        print("Navigate to plate ID camera view controller");
        HUD.showWaiting()
        let superview = self
        DispatchQueue.global(qos: .default).async {
            let camersVCNp = WTPlateIDCameraViewController()
            camersVCNp.delegate = superview
            DispatchQueue.main.async {
                superview.present(camersVCNp, animated: true) {
                    HUD.hideWaiting()
                }
            }
        }
        UMEventsManager.Events.licenseCamera.count()
    }
    
    func actionHand() {
        print("Navigate to camera view controller");
        let searchResultsVC   = SearchViewController()
        self.navigationController?.pushViewController(searchResultsVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    var addedLineView = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (!addedLineView)
        {
            if let tabsView = self.view.viewWithTag(38) as? UIScrollView {
                let lineview = UIView(frame: CGRect(x: 0, y: 47, width: self.view.bounds.width, height: 2))
                lineview.backgroundColor = UIColor.lightGray
                tabsView.insertSubview(lineview, at: tabsView.subviews.count-1)
            }
            addedLineView = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SearchBaseViewController:CameraResultDelegate {
    func cameraResult(_ vinCode: String!, form viewController: CameraViewController!) {
        
        print("vinCode = \(vinCode)")
        self.searchDeatilWithVin(vinCode: vinCode)
        
        UMEventsManager.Events.vinScanSuccess.count()
    }
}

extension SearchBaseViewController:PlateIDCameraResultDelegate {
    
     func cameraResultNP(_ plateResult: PlateResult!, form viewController: WTPlateIDCameraViewController!) {
        
        print("plate license: \(plateResult.license), color: \(plateResult.color), confidence: \(plateResult.nConfidence), time: \(plateResult.nTime)")
        
        guard let license:String  = plateResult.license,
            license.characters.count > 2 else {
                return
        }
        
        self.searchDeatilWithNP(licensePlate:license)
        
        UMEventsManager.Events.licenseScanSuccess.count()
    }
}
