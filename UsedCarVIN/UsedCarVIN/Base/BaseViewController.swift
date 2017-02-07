//
//  BaseViewController.swift
//  UsedCarVIN
//
//  Created by wang yongchao on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var didSetupConstraints = false
    var isHiddenTabbar      = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barStyle = .black;
        self.view.backgroundColor = UIColor.white

        setLeftBarNavigationItem()
        setRightBarNavigationItem()

        commonInit()
    }

    func commonInit() {
        //fatalError("commonInit() MUST be overridden by a subclass")
         self.view.setNeedsUpdateConstraints()
    }

    func requestData() {
        // request Data
    }

    func setRightBarNavigationItem() {
        //set  rightBarButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = isHiddenTabbar
    }
    func setLeftBarNavigationItem()  {

        let actionButton = UIButton.init(type: .custom)
        actionButton.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        actionButton .setImage(UIImage.init(named: "icon_return"), for: .normal)
        let leftButtonItem = UIBarButtonItem(customView: actionButton)
        actionButton.addTarget(self, action:#selector(backAction(sender:)) , for: .touchUpInside)

        self.navigationItem.leftBarButtonItem =  leftButtonItem
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
}
