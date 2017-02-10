//
//  SearchVINViewController.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/19.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class SearchVINViewController: SearchContentViewController {

    var vinSharedManager = VINSharedManager.sharedInstance()!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        self.inputTextField.delegate = self

        self.inputTextField.addValidation(validate: .required)
        self.inputTextField.addValidation(validate: .vin)

        self.cameraButton.addTarget(self, action: #selector(action), for: .touchUpInside)
    }


    func searchDeatil(vinCode:String){

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
                    vehicle.vin = superview.inputTextField.text
                    NSLog("set vin")
                }
            }
            
            
            let path = CARVIN_API_URL+"vin/Vehicle?VIN=\(vinCode)"//

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
                    vehicle.vin = superview.inputTextField.text
                    NSLog("set vin")
                    
                    DispatchQueue.main.async {
                        NSLog("show result")
                        HUD.hideWaiting()
                        superview.delegate?.searchedResult(model: vehicle, searchViewController: superview)
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

    override func action() {

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

    override func search() {

        guard let vinCode = self.inputTextField.text else {
            return
        }

        UMEventsManager.Events.vinSearch.count()

        self.searchDeatil(vinCode: vinCode)
    }

    override func commonInit() {
        super.commonInit()

        self.view.addSubview(inputTextField)
        self.view.addSubview(keyboardView)
        self.view.setNeedsUpdateConstraints()

        self.inputTextField.rightView          = self.cameraButton
        self.inputTextField.rightViewMode      = .always
        self.keyboardView.delegate = self
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
        // Dispose of any resources that can be recreated.
    }


    let inputTextField:UITextField = {
        let textfield = UITextField()
        textfield.borderStyle       = .roundedRect
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.placeholder       = "请输入车辆识别码(VIN)"
        textfield.returnKeyType     = .done
        textfield.keyboardType      = .alphabet
        textfield.clearButtonMode   = .always
        return textfield
    }()

    let cameraButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        let voiceImage = UIImage(named:"icon_camera_small")
        button.setImage(voiceImage, for: .normal)
        return button
    }()

    let keyboardView:CustomKeyboardView = {
        let keys:String       = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let rowKeyCount:[Int] = [10,7,7,7,5]
        let keyboard          = CustomKeyboardView(with: keys, rowKeyCount: rowKeyCount, frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return keyboard
    }()
}

extension SearchVINViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = textField.text?.uppercased()
        textField.resignFirstResponder()

        self.validate(textControl: self.inputTextField)

        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
extension SearchVINViewController:CameraResultDelegate {
    func cameraResult(_ vinCode: String!, form viewController: CameraViewController!) {

        print("vinCode = \(vinCode)")

        self.inputTextField.text = vinCode

        self.validate(textControl: self.inputTextField)

        self.searchDeatil(vinCode: vinCode)

        UMEventsManager.Events.vinScanSuccess.count()
    }
}
extension SearchVINViewController:CustomKeyboardViewDelegate{
    func didChangeContent(text: String, keyboard: CustomKeyboardView) {
        
        self.validate(textControl: self.inputTextField)
    }
    func inputTextField(keyboard: CustomKeyboardView) -> UITextField {
        
        return self.inputTextField
    }
}
