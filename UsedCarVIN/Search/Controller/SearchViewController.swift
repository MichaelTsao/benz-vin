
//
//  SearchViewController.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/19.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyButton
import UIColor_Hex_Swift
import Pager

class SearchViewController:  PagerController,PagerDataSource {

    let vinController = SearchVINViewController()
    let npController  = SearchNPViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barStyle = .black;
        self.view.backgroundColor = UIColor.white
//        self.title = "星睿VIN鉴定"

        self.setupPager()
        
        guard let barButtonItem   = UIBarButtonItem.whiteBackButton(),
            let button:UIButton = barButtonItem.customView as? UIButton else {
                return
        }
        
        self.navigationItem.leftBarButtonItem = barButtonItem
        button.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)

        
    }

    func backAction(sender:AnyObject) {
        
        if self.navigationController != nil {
            
            self.navigationController!.popViewController(animated: true)
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    deinit {
        NSLog("@%", self)
    }

//    func setRightBarNavigationItem() {
//        
//        guard let barButtonItem   = UIBarButtonItem.whiteBackButton(),
//            let button:UIButton = barButtonItem.customView as? UIButton else {
//                return
//        }
//        
//        self.navigationItem.leftBarButtonItem = barButtonItem
//        
////        button.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
//    }
    
    
    func setupPager(){
        self.dataSource = self
        self.setupPager(tabNames: ["VIN","车牌"], tabControllers: [vinController,npController])
        customizeTab()
        vinController.delegate = self
        npController.delegate  = self
    }

    // Customising the Tab's View
    func customizeTab() {
        indicatorColor             = UIColor.black
        selectedTabTextColor       = .black
        tabsViewBackgroundColor    = UIColor.white
        contentViewBackgroundColor = UIColor.gray
        tabsTextColor              = .lightGray


        tabLocation                = PagerTabLocation.top
        tabHeight                  = 49
        indicatorHeight            = 2.0
        tabWidth                   = self.view.bounds.width/2

        startFromSecondTab         = false
        centerCurrentTab           = true
        fixFormerTabsPositions     = false
        fixLaterTabsPosition       = false
        animation                  = PagerAnimation.during


        tabsTextFont               = UIFont(name: "HelveticaNeue-Bold", size: 20)!
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func cancelDelays(){

        guard let contentView = self.view.viewWithTag(34) else {
            return
        }
        
        if let scrollview = contentView.subviews.first as? UIScrollView {
            scrollview.delaysContentTouches = false
            scrollview.canCancelContentTouches = true
        }
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

            self.cancelDelays()
        }
    }


    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }
}
extension SearchViewController:SearchResultsProtocol {
    func searchedResult(model:VehicleModel, searchViewController: SearchContentViewController) {
        let searchResultsVC   = SearchResultsViewController()
        searchResultsVC.model = model
        self.navigationController?.pushViewController(searchResultsVC, animated: true)
    }
}
