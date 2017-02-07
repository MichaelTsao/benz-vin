//
//  ReportsViewController.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class ReportsViewController: BaseViewController {


    var dataArray:[VehicleModel] = []

    let tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.table_background
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的报告"
        self.view.backgroundColor = UIColor.table_background

        HUD.showWaiting()
        //加载Mocks数据
        DispatchQueue.global(qos: .default).async {
            let array = [Mocks().vehicle1,Mocks().vehicle2,Mocks().vehicle3]
            DispatchQueue.main.async {
                HUD.hideWaiting()
                self.dataArray = array
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
        if (!didSetupConstraints) {

            tableView.snp.makeConstraints({ (make) in
                make.edges.equalTo(self.view)
            })

            didSetupConstraints = true
        }

        super.updateViewConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

        cell!.titleLabel.text   = vehicle.licensePlate
        cell!.dateLabel.text    = vehicle.bornYear
        cell!.contentLabel.text = vehicle.title
        cell!.vinLabel.value    = vehicle.vin

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let resultsViewController   = SearchResultsViewController()
        resultsViewController.model = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(resultsViewController, animated: true)
    }
}
