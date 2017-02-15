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
    
    let detailButton:UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.clear
//        button.setImage(UIImage(named:"ic_keyboard_arrow_right_48px-128 (2)"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 370)
        return button
    }()
    
    let detailButtonWei:UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.clear
//        button.setImage(UIImage(named:"ic_keyboard_arrow_right_48px-128 (2)"), for: .normal)
        button.frame = CGRect(x: 0, y: 370, width: UIScreen.main.bounds.width, height: 300)
        return button
    }()
    
    var model:VehicleModel? = nil{
        willSet{
            
            self.infoView.carModelsTitleLabel.text = newValue?.variant
            self.title = newValue?.regNo
            
            if newValue?.prodDate == "" {
                self.infoView.ProductLabel.value = ""
            }else{
                self.infoView.ProductLabel.value = (newValue?.prodDate?.substring(to: 4))!+"年"
            }
            
//            self.infoView.productAreaLabel.value = everyTypeToString(from: newValue?.location ?? "")
            
            if (newValue?.vin?.substring(to: 3)) == "LE4" {
                self.infoView.productAreaLabel.text = "国产"
            }else{
                self.infoView.productAreaLabel.text = "进口"
            }
            
            self.infoView.registrationDateLabel.value = newValue?.regDate
            self.infoView.usedCarLabel.value = (newValue?.used)!+"次"
            self.infoView.priceNewCarLabel.value = newValue?.newPrice
            self.infoView.priceNowLabel.value = newValue?.averagePrice
            self.infoView.ageLabel.value = newValue?.age
            self.infoView.milesLabel.value = (newValue?.miles)!+"公里"
            self.infoView.normalRepair.value = (newValue?.orderRepair)!+"次"
            self.infoView.penqi.value = (newValue?.sprayRepair)!+"次"
            self.infoView.banjin.value = (newValue?.sheetMetal)!+"次"
            self.infoView.suopei.value = (newValue?.claimDemage)!+"次"
            self.infoView.baoyang.value = newValue?.maintainDate
            self.infoView.licheng.value = (newValue?.averageMiles)!+"公里"
            self.infoView.circle.value = (newValue?.repair)!+"次\n维修"
            self.infoView.circleTwo.value = (newValue?.maintainTimes)!+"次\n保养"
            
//            self.daimlerVehicleMode(isDaimler: newValue?.isDaimler ?? false , vin:(newValue?.vin)!)
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "车辆信息"
//        self.isHiddenTabbar            = true
        self.view.backgroundColor      = UIColor.back_background
        self.detailButton.addTarget(self, action: #selector(showDetailBase), for: .touchUpInside)
        self.detailButtonWei.addTarget(self, action: #selector(showDetailBaseWei), for: .touchUpInside)
//        self.detailButtonBao.addTarget(self, action: #selector(showDetailBaseBao), for: .touchUpInside)
    }
    
    func showDetailBaseWei() {
//        let detailVC = VehicleDetailViewController()
        let detailVC = ReportsViewController()
        detailVC.theVin = (model?.vin)!
        self.navigationController?.pushViewController(detailVC, animated: true)
//        UMEventsManager.Events.showVehicleAllDetail.count()
    }

    func showDetailBaseBao() {
        let detailVC = ReportsViewController()
        detailVC.theVin = (model?.vin)!
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func showDetailBase() {
        let detailVC = VehicleDetailViewController()
        detailVC.model = self.model
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    

    override func commonInit() {
        
        self.view.addSubview(self.infoView)
//        self.view.addSubview(self.detailButton)
        self.view.addSubview(self.detailButtonWei)
//        self.view.addSubview(self.detailButtonBao)
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
                make.height.equalTo(500)
            })

//            self.tableView.snp.makeConstraints({ make in
//                make.left.bottom.right.equalTo(self.view)
//                make.top.equalTo(self.infoView.snp.bottom)
//            })
//
//            self.imageView.snp.makeConstraints({ (make) in
//                make.center.equalTo(self.tableView)
//                make.size.equalTo(self.imageView.image!.size)
//            })
//
//            self.detailButton.snp.makeConstraints({ (make) in
//                make.size.equalTo(CGSize(width: 13, height: 22))
//                make.centerY.equalTo(self.infoView)
//                make.right.equalTo(self.infoView.snp.right).offset(-20)
//            })
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

//extension SearchResultsViewController:UITableViewDelegate,UITableViewDataSource {
//    
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return self.dataArray.count
//
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return RecordTableViewCell.cellHeight()
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let identifierString = RecordTableViewCell.reuseIdentifierString!
//
//        var cell:RecordTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifierString) as? RecordTableViewCell
//
//        if cell == nil {
//            cell = RecordTableViewCell(style: .default, reuseIdentifier: identifierString)
//        }
//
//        let maintenance = self.dataArray[indexPath.row]
//
////        cell!.titleLabel.text     = maintenance.type
////        cell!.kmLabel.text        = maintenance.kilometres
////        cell!.dateLabel.text      = maintenance.date
////        cell!.componentLabel.text = maintenance.component
////        cell!.contentLabel.text   = maintenance.content
//        
//        cell!.titleLabel.text     = maintenance.details
//        cell!.kmLabel.text        = maintenance.miles
//        cell!.dateLabel.text      = maintenance.maintainDate
//        cell!.componentLabel.text = maintenance.details
//        cell!.contentLabel.text   = maintenance.desc
//        
//        /*
//        var regNo:String?//"":"京NXX651",
//        var maintainDate:String?//"":"2014-10-17",
//        var details:String?//"":"保养",
//        var desc:String?//"AMG 0W40 MB229.5/A保养检查更换机油机滤/刹车片/刹车片 后ML/刹车防响膏/拆卸/安装前后车轮/摩擦片磨损传感器/更换前轴的制动摩擦衬块/更换后轴制动摩擦衬块/机油滤芯",
//        var miles:String?//60976,
//        var sanName:String?//null,
//        var vin:String?//4JG1641861A355197
//        */
//        
//        return cell!
//    }
//}
//
//extension SearchResultsViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
//    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
//
//        guard let editImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
//            return
//        }
//
//        self.imageView.image = editImage
//
//        picker.dismiss(animated: true, completion: nil)
//    }
//}
