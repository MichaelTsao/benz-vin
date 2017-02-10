//
//  SearchNPViewController.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/19.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class SearchNPViewController: SearchContentViewController {

    var vinSharedManager = VINSharedManager.sharedInstance()!

    
    let provinces:[String] = {
        return ["京","津","沪","闽","冀","豫",
                "云","辽","黑","湘","皖","鲁",
                "新","苏","浙","赣","桂","甘",
                "晋","蒙","陕","吉","渝","贵",
                "粤","青","藏","琼"]
    }()

    var province:String = "" {
        willSet{
            self.provinceButton.setTitle(newValue, for: .normal)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        self.province = "京"

        self.inputTextField.delegate = self
        self.inputTextField.addValidation(validate: .required)
        self.inputTextField.addValidation(validate: .licensePlate)

        self.provinceButton.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        self.cameraButton.addTarget(self, action: #selector(action), for: .touchUpInside)
    }

    override func action() {

        print("Navigate to plate ID camera view controller");

        HUD.showWaiting()

        let superview = self
        DispatchQueue.global(qos: .default).async {

            let camersVC = WTPlateIDCameraViewController()
            camersVC.delegate = superview

            DispatchQueue.main.async {
                superview.present(camersVC, animated: true) {
                    HUD.hideWaiting()
                }
            }
        }

        UMEventsManager.Events.licenseCamera.count()
    }

    override func search() {

        guard let licensePlate = self.inputTextField.text,
              let province     = self.provinceButton.title(for: .normal) else {
            return
        }

        self.searchDeatilWithNP(licensePlate: province + licensePlate)

        UMEventsManager.Events.licenseSearch.count()
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
                
                //生成模型 跳转到详情页面
                //                        let vehicle = VehicleModel()
                //                        NSLog("init VehicleModel")
                
                vehicle.parseJson(orcData: dataDic!)
                NSLog("parse vehicle")
                
//                //需要放在parse下面，不然会数据会被覆盖
//                vehicle.vin =
//                NSLog("set vin")
//                
//                DispatchQueue.main.async {
//                    NSLog("show result")
//                    HUD.hideWaiting()
//                    superview.delegate?.searchedResult(model: vehicle, searchViewController: superview)
//                }
                
                //查询完号牌之后，根据vin覆盖一次
                self.vinSharedManager.searchVINInfo(vehicle.vin) { dict in
                    NSLog("init VinSharedManager")
                    
                    if let data = dict as? [String:String] {
                        vehicle.parse(with: data)
                        NSLog("parse vehicle")
                        
                        HUD.hideWaiting()
                        self.delegate?.searchedResult(model: vehicle, searchViewController: self)

                    }
                }
                
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
    
    func showPicker() {
        let alertController = UIAlertController(title: "选择车辆归属地", message: nil, preferredStyle: .actionSheet)

        let superview = self
        for province in self.provinces {
            let action = UIAlertAction(title: province, style: .default, handler: { action in

                superview.province = action.title!
            })
            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { _ in
        }

        alertController.addAction(cancelAction)

        let height:NSLayoutConstraint = NSLayoutConstraint(
            item: alertController.view,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: self.view.frame.height * 0.55)

        alertController.view.addConstraint(height);

        self.present(alertController, animated: true, completion: nil)
    }

    override func commonInit() {
        super.commonInit()

        self.view.addSubview(inputTextField)
        self.view.addSubview(keyboardView)
        self.setProvinceView()

        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {

        if (!didSetupConstraints) {

            let superview = self

            inputTextField.snp.makeConstraints { make in
                make.edges.equalTo(superview.inputContentView)
            }

            keyboardView.snp.makeConstraints({ make in
                make.left.right.equalTo(superview.inputContentView)
                make.top.equalTo(superview.inputContentView.snp.bottom).offset(20)
                make.bottom.equalTo(superview.searchButton.snp.top).offset(-20)
            })
        }

        super.updateViewConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    let provinceButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()

    let cameraButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        let voiceImage = UIImage(named:"icon_camera_small")
        button.setImage(voiceImage, for: .normal)
        return button
    }()

    let inputTextField:UITextField = {
        let textfield = UITextField()
        textfield.borderStyle       = .roundedRect
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.placeholder       = "请输入车辆牌照"
        textfield.returnKeyType     = .done

        return textfield
    }()


    func setProvinceView() {
        let w:CGFloat = 50
        let h:CGFloat = 30
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        provinceButton.frame = CGRect(x: 0, y: 0, width: w, height: h)
        leftView.addSubview(provinceButton)

        let grayLine = UIView(frame: CGRect(x: w, y: 2, width: 1, height: h-2*2))
        grayLine.backgroundColor = UIColor.lightGray
        leftView.addSubview(grayLine)

        self.inputTextField.leftView      = leftView
        self.inputTextField.leftViewMode  = .always
        self.inputTextField.delegate      = self

        self.inputTextField.rightView     = self.cameraButton
        self.inputTextField.rightViewMode = .always

        self.keyboardView.delegate = self
    }

    let keyboardView:CustomKeyboardView = {
        let keyboard = CustomKeyboardView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return keyboard
    }()
}

extension SearchNPViewController:UITextFieldDelegate{

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}


extension SearchNPViewController:CustomKeyboardViewDelegate{
    func didChangeContent(text: String, keyboard: CustomKeyboardView) {

        self.validate(textControl: self.inputTextField)
    }
    func inputTextField(keyboard: CustomKeyboardView) -> UITextField {

        return self.inputTextField
    }
}

extension SearchNPViewController:PlateIDCameraResultDelegate {
    func cameraResultNP(_ plateResult: PlateResult!, form viewController: WTPlateIDCameraViewController!) {

        print("plate license: \(plateResult.license), color: \(plateResult.color), confidence: \(plateResult.nConfidence), time: \(plateResult.nTime)")

        guard let license:String  = plateResult.license,
              license.characters.count > 2 else {
            return
        }

        self.province            = license.substring(to: 1)
        self.inputTextField.text = license.substring(from: 1)

        self.validate(textControl: self.inputTextField)

        self.searchDeatilWithNP(licensePlate:license)

        UMEventsManager.Events.licenseScanSuccess.count()
    }
}
