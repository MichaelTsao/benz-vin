//
//  ReportsViewController.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class ReportsViewController: BaseViewController {
    
    var dataArray:[MaintenanceModel] = []
    
    var theVin = ""
    
    let tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.table_background
        return tableView
    }()
    
    override func setRightBarNavigationItem() {
        guard let barButtonItem   = UIBarButtonItem.whiteBackButton(),
            let button:UIButton = barButtonItem.customView as? UIButton else {
                return
        }
        self.navigationItem.leftBarButtonItem = barButtonItem
        button.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "维保记录"
        self.view.backgroundColor = UIColor.white
        let path = CARVIN_API_URL+"vin/Vehicle/History?VIN=\(theVin)"
        print("path theVin->:"+path);
        XBNetHandle.getRequestWithUrlStr(urlStr: path, successBlock: { (result) in
            let str = String(data:result!, encoding:String.Encoding.utf8)
            print("Json Str:");
            print(str ?? "")
            let json : AnyObject! = try? JSONSerialization
                .jsonObject(with: result!, options:JSONSerialization.ReadingOptions.allowFragments) as AnyObject!
            print("Json Object:"); print(json)
            
            let number :Int = json?["resultCode"] as! Int
            
            if (number == 0)
            {
                print("resultCode->:");
                print(json)
                
                let dataDic = json?["data"] as? NSArray
                
                print("resultCode-dataDic>:");
                print(dataDic ?? "")
                
                //                dataArray = []
                self.tableView.isHidden = false
                
                //                let names = ["hell0","world","let's","start"]
                for var modelDic in dataDic! {
                    let model = MaintenanceModel()
                    model.type       = "维修"
                    model.kilometres = "40027公里"
                    model.date       = "2016-07-01"
                    model.component  = "空调"
                    model.content    = "更换氟管密封圈"
                    
                    model.regNo = everyTypeToString(from:(modelDic as AnyObject).object(forKey: "regNo") ?? "")
                    model.maintainDate = everyTypeToString(from:(modelDic as AnyObject).object(forKey: "maintainDate") ?? "")
                    model.details = everyTypeToString(from:(modelDic as AnyObject).object(forKey: "details") ?? "")
                    model.desc = everyTypeToString(from:(modelDic as AnyObject).object(forKey: "desc") ?? "")
                    //                    model.miles    = String(describing:(modelDic as AnyObject).object(forKey: "miles"))
//                    if let number = (modelDic as AnyObject).object(forKey: "miles") { // 建议的做法
//                        model.miles = String(describing:number)+"公里"
//                    }else{
//                        model.miles = ""
//                    }
                    model.miles = everyTypeToString(from: (modelDic as AnyObject).object(forKey: "miles") ?? "")+"公里"
                    
                    
                    
                    if let sanName = (modelDic as AnyObject).object(forKey: "sanName") {
                        model.sanName = String(describing:sanName)
                    }else{
                        model.sanName = "SA1"
                    }
                    if model.sanName == "<null>" {
                        model.sanName = "SA1"
                    }
                    
                    model.vin    = everyTypeToString(from: (modelDic as AnyObject).object(forKey: "vin") ?? "")
                    self.dataArray.append(model)
                    print(modelDic)
                }
                
                self.tableView.isHidden = false
                self.tableView.reloadData()
                
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
        
        HUD.showWaiting()
        //加载Mocks数据
        DispatchQueue.global(qos: .default).async {
            //            let array = [Mocks().vehicle1,Mocks().vehicle2,Mocks().vehicle3]
            DispatchQueue.main.async {
                HUD.hideWaiting()
                //                self.dataArray = array
                self.tableView.reloadData()
            }
        }
    }
    
    override func commonInit() {
        self.tableView.delegate   = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        if (!didSetupConstraints) {
            tableView.snp.makeConstraints({ (make) in
                make.edges.equalTo(self.view)
            })
            didSetupConstraints = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ReportsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ReportTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifierString = ReportTableViewCell.reuseIdentifierString!
        
        var cell:ReportTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifierString) as? ReportTableViewCell
        
        if cell == nil {
            cell = ReportTableViewCell(style: .default, reuseIdentifier: identifierString)
        }
        
        let vehicle = self.dataArray[indexPath.row]
        
        print("类型---"+vehicle.details!)
        
        if vehicle.details=="保养"  {
        cell!.typeNameTitleLabel.text = "保";//
        }else{
        cell!.typeNameTitleLabel.text = "修";//维
        }
        
        cell!.descLabel.text   = vehicle.desc
        cell!.dateLabel.text    = vehicle.maintainDate
        cell!.mileLabel.text    = vehicle.miles
//        cell!.contentLabel.text = vehicle.regNo
//        cell!.sanLabel.value    = vehicle.sanName
        cell!.typeLabel.text = vehicle.details
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let resultsViewController   = SearchResultsViewController()
//        resultsViewController.model = self.dataArray[indexPath.row]
//        self.navigationController?.pushViewController(resultsViewController, animated: true)
    }
}


