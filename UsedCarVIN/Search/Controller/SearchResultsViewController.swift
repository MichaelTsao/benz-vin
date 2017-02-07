//
//  SearchResultsViewController.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/19.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class SearchResultsViewController: BaseViewController {

    let infoView  = CarInfoView()
    let tableView = UITableView(frame: .zero, style: .plain)
    let imageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bg_camera"))
        imageView.isUserInteractionEnabled = true

        let imageSize = imageView.image?.size ?? CGSize(width: 100, height: 100)

        let actionLabel = UILabel(frame: CGRect(x: 4,
                                                y: imageSize.height/2+15,
                                                width: imageSize.width-8,
                                                height: 20))

        actionLabel.font = UIFont.systemFont(ofSize: 12)
        actionLabel.text = "点击拍摄照片"
        actionLabel.textColor     = UIColor.gray
        actionLabel.textAlignment = .center
        actionLabel.backgroundColor = UIColor.table_background
        imageView.addSubview(actionLabel)

        let imageLabel = UILabel(frame: CGRect(x: 0,
                                               y: imageSize.height/2+35,
                                               width: imageSize.width,
                                               height: 20))

        imageLabel.font = UIFont.systemFont(ofSize: 12)
        imageLabel.text = "添加车辆速记"
        imageLabel.textColor     = UIColor.gray
        imageLabel.textAlignment = .center
        imageLabel.backgroundColor = UIColor.table_background
        imageView.addSubview(imageLabel)

        return imageView
    }()
    let detailButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named:"icon_right_white_arrow"), for: .normal)
        return button
    }()

    var dataArray:[MaintenanceModel] = []

    var model:VehicleModel? = nil{
        willSet{
//            self.infoView.titleLabel.text         = newValue?.title
//            self.infoView.vinLabel.value          = newValue?.vin
//            self.infoView.locationLabel.value     = newValue?.location
//            self.infoView.factoryLabel.value      = newValue?.factory
//            self.infoView.bornLabel.value         = newValue?.bornYear
//            self.infoView.powerLabel.value        = newValue?.power
//            self.infoView.fuelLabel.value         = newValue?.fuelType
//            self.infoView.cylindersLabel.value    = newValue?.licensePlate
//            self.infoView.carModeLabel.value      = newValue?.carMode
//            self.infoView.priceLabel.value        = newValue?.price
            
            self.infoView.titleLabel.text         = newValue?.title
            self.infoView.vinLabel.value          = newValue?.vin
            self.infoView.locationLabel.value     = newValue?.colour
            self.infoView.factoryLabel.value      = newValue?.model
            self.infoView.bornLabel.value         = newValue?.variant
            self.infoView.powerLabel.value        = newValue?.regNo
            self.infoView.fuelLabel.value         = newValue?.trim
            self.infoView.cylindersLabel.value    = newValue?.prodDate
            self.infoView.carModeLabel.value      = newValue?.regDate
            
//            let number :Int = (newValue?.newPrice)!
//            
//            self.infoView.priceLabel.value        = String(describing: number)
            
            if let number = newValue?.newPrice { // 建议的做法
                self.infoView.priceLabel.value = String(describing:number)
            }else{
                self.infoView.priceLabel.value = ""
            }
            
//            lazy var locationLabel:UILabel     = CarInfoView.initLabel(titleLabel:"车牌")
//            lazy var factoryLabel:UILabel      = CarInfoView.initLabel(titleLabel:"车系")
//            lazy var bornLabel:UILabel         = CarInfoView.initLabel(titleLabel:"车型")
//            lazy var powerLabel:UILabel        = CarInfoView.initLabel(titleLabel:"颜色")
//            lazy var fuelLabel:UILabel         = CarInfoView.initLabel(titleLabel:"内饰")
//            lazy var cylindersLabel:UILabel    = CarInfoView.initLabel(titleLabel:"生产年份")
//            lazy var carModeLabel:UILabel      = CarInfoView.initLabel(titleLabel:"上牌日期")
//            lazy var priceLabel:UILabel        = CarInfoView.initLabel(titleLabel:"车龄")
//            
//            var vin:String?                //VIN
//            var :String?                //车牌
//            var :String?                //车系
//            var variant:String?                //车型
//            var colour:String?                //颜色
//            var trim:String?                //内饰
//            var prodDate:String?                //生产年份 Date
//            var regDate:String?                //上牌日期 Date
//            var age:Int?                //车龄 int
//            var newPrice:Int?                //新车指导价
//            var used:Int?                //过户次数
//            var miles:Int?                //里程
//            var repair:Int?                //维修次数
//            var orderRepair:Int?                //一般维修次数
//            var sprayRepair:Int?                //喷漆维修次数
//            var sheetMetal:Int?                //钣金维修次数
//            var claimDemage:Int?                //索赔工作次数
//            var maintain:String?                //保养规律与否
//            var maintainTimes:Int?                //保养次数
//            var averageMiles:Int?                //平均间隔里程
            
            self.daimlerVehicleMode(isDaimler: newValue?.isDaimler ?? false , vin:(newValue?.vin)!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "车辆信息"

        self.isHiddenTabbar            = true
        self.view.backgroundColor      = UIColor.table_background
        self.detailButton.addTarget(self, action: #selector(showDetail), for: .touchUpInside)
    }
    
    func showDetail() {
        let detailVC = VehicleDetailViewController()
        detailVC.model = self.model
        self.navigationController?.pushViewController(detailVC, animated: true)

        UMEventsManager.Events.showVehicleAllDetail.count()
    }

    func takePicture(){
        let imagePickerVC               = UIImagePickerController()
        imagePickerVC.allowsEditing     = true
        imagePickerVC.sourceType        = .camera
        imagePickerVC.cameraCaptureMode = .photo
        imagePickerVC.delegate          = self
        self.present(imagePickerVC, animated: true, completion: nil)
    }

    func daimlerVehicleMode(isDaimler:Bool, vin:String) {
        //隐藏保养信息
        self.imageView.isHidden = false
        self.tableView.isHidden = true

        //如果是Daimler车辆则显示保养信息隐藏拍摄图片
//        if isDaimler == true {
//            dataArray = [Mocks().maintenance1,Mocks().maintenance2,Mocks().maintenance3]
//            self.imageView.isHidden = true
//            self.tableView.isHidden = false
//        }
        
      //查找维修记录
//        let path = "http://120.77.66.101:8888/Vehicle/History?VIN=4JG1641861A355196"//4JG1641861A355196
        let path = "http://120.77.66.101:8888/Vehicle/History?VIN=\(vin)"
        
        print("path->:"+path);
        
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
                self.imageView.isHidden = true
                self.tableView.isHidden = false
                
//                let names = ["hell0","world","let's","start"]
                for var modelDic in dataDic! {
                    let model = MaintenanceModel()
                    model.type       = "维修"
                    model.kilometres = "40027公里"
                    model.date       = "2016-07-01"
                    model.component  = "空调"
                    model.content    = "更换氟管密封圈"
                    
                    model.regNo = (modelDic as AnyObject).object(forKey: "regNo") as! String?
                    model.maintainDate = (modelDic as AnyObject).object(forKey: "maintainDate") as! String?
                    model.details = (modelDic as AnyObject).object(forKey: "details") as! String?
                    model.desc = (modelDic as AnyObject).object(forKey: "desc") as! String?
//                    model.miles    = String(describing:(modelDic as AnyObject).object(forKey: "miles"))
                    
                    if let number = (modelDic as AnyObject).object(forKey: "miles") { // 建议的做法
                        model.miles = String(describing:number)+"公里"
                    }else{
                         model.miles = ""
                    }
                    
                    model.sanName    = String(describing:(modelDic as AnyObject).object(forKey: "sanName"))
//                    model.vin    = (modelDic as AnyObject).object(forKey: "vin") as! String?
                    self.dataArray.append(model)
                    print(modelDic)
                }
                
                self.imageView.isHidden = true
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
        
    }

    override func commonInit() {

        let tapInfoGesture = UITapGestureRecognizer(target: self, action: #selector(showDetail))
        self.infoView.addGestureRecognizer(tapInfoGesture)

        self.tableView.tableHeaderView = self.headerView()
        self.tableView.separatorStyle  = .none
        self.tableView.backgroundColor = UIColor.table_background
        self.tableView.delegate        = self
        self.tableView.dataSource      = self


        let tapImageGesture = UITapGestureRecognizer(target: self, action: #selector(takePicture))
        self.imageView.addGestureRecognizer(tapImageGesture)

        self.view.addSubview(self.infoView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.detailButton)
        self.view.setNeedsUpdateConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController!.navigationBar.hiddenBottomLine()
    }

    override func setRightBarNavigationItem() {

        guard let barButtonItem   = UIBarButtonItem.whiteBackButton(),
              let button:UIButton = barButtonItem.customView as? UIButton else {
            return
        }

        self.navigationItem.leftBarButtonItem = barButtonItem

        button.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
    }
    override func updateViewConstraints() {

        if (!didSetupConstraints) {

            self.infoView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.view).offset(64)
                make.left.right.equalTo(self.view)
                make.height.equalTo(180)
            })

            self.tableView.snp.makeConstraints({ make in
                make.left.bottom.right.equalTo(self.view)
                make.top.equalTo(self.infoView.snp.bottom)
            })

            self.imageView.snp.makeConstraints({ (make) in
                make.center.equalTo(self.tableView)
                make.size.equalTo(self.imageView.image!.size)
            })

            self.detailButton.snp.makeConstraints({ (make) in
                make.size.equalTo(CGSize(width: 13, height: 22))
                make.centerY.equalTo(self.infoView)
                make.right.equalTo(self.infoView.snp.right).offset(-20)
            })
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }

    deinit {
        print("deinit \(self)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func headerView() -> UIView {

        let frame   = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50)
        let headerView         = RecordHeaderView(frame:frame)
        headerView.title.text  = "保养维修记录"
        return headerView
    }
}

extension SearchResultsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.dataArray.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return RecordTableViewCell.cellHeight()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifierString = RecordTableViewCell.reuseIdentifierString!

        var cell:RecordTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifierString) as? RecordTableViewCell

        if cell == nil {
            cell = RecordTableViewCell(style: .default, reuseIdentifier: identifierString)
        }

        let maintenance = self.dataArray[indexPath.row]

//        cell!.titleLabel.text     = maintenance.type
//        cell!.kmLabel.text        = maintenance.kilometres
//        cell!.dateLabel.text      = maintenance.date
//        cell!.componentLabel.text = maintenance.component
//        cell!.contentLabel.text   = maintenance.content
        
        cell!.titleLabel.text     = maintenance.details
        cell!.kmLabel.text        = maintenance.miles
        cell!.dateLabel.text      = maintenance.maintainDate
        cell!.componentLabel.text = maintenance.details
        cell!.contentLabel.text   = maintenance.desc
        
        /*
        var regNo:String?//"":"京NXX651",
        var maintainDate:String?//"":"2014-10-17",
        var details:String?//"":"保养",
        var desc:String?//"AMG 0W40 MB229.5/A保养检查更换机油机滤/刹车片/刹车片 后ML/刹车防响膏/拆卸/安装前后车轮/摩擦片磨损传感器/更换前轴的制动摩擦衬块/更换后轴制动摩擦衬块/机油滤芯",
        var miles:String?//60976,
        var sanName:String?//null,
        var vin:String?//4JG1641861A355196
        */
        
        return cell!
    }
}

extension SearchResultsViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){

        guard let editImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            return
        }

        self.imageView.image = editImage

        picker.dismiss(animated: true, completion: nil)
    }
}
