//
//  SplashPageViewController.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/29.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit
import SwiftyButton

class SplashPageViewController: BaseViewController {

    let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    let contentView:UIView = {
        let content = UIView()
        return content
    }()

    let imageNames = ["splash-1","splash-2","splash-3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.table_background
        //add close tapAction
        if let lastImageView = self.contentView.subviews.last {
            lastImageView.isUserInteractionEnabled = true

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backAction(sender:)))
            lastImageView.addGestureRecognizer(tapGesture)
        }
    }

    override func backAction(sender: AnyObject) {
        
        
        
        let tabbarVC = UITabBarController()

        //SearchViewController
        let nav_search = UINavigationController(rootViewController: SearchViewController())
        nav_search.tabBarItem.title = "查询"
        nav_search.tabBarItem.image = UIImage(named: "icon_search_normal")
        nav_search.tabBarItem.selectedImage = UIImage(named: "icon_search_pressed")?.withRenderingMode(.alwaysOriginal)
        nav_search.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.black], for: .selected)

        //ReportsViewController
//        let nav_report = UINavigationController(rootViewController: ReportsViewController())
//        nav_report.tabBarItem.title = "我的报告"
//        nav_report.tabBarItem.image = UIImage(named: "icon_report_normal")
//        nav_report.tabBarItem.selectedImage = UIImage(named: "icon_report_pressed")?.withRenderingMode(.alwaysOriginal)
//        nav_report.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.black], for: .selected)

        //Set
//        tabbarVC.setViewControllers([nav_search,nav_report], animated: true)
        tabbarVC.delegate = self

        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionFade
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)

//        view.window?.rootViewController  = tabbarVC
        
//        view.window?.rootViewController  = nav_search
        
        view.window?.makeKeyAndVisible()
    }

    override func commonInit() {

        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)

        for imageName in self.imageNames {
            let imageView = UIImageView(image: UIImage(named: imageName))
            self.contentView.addSubview(imageView)
        }

        super.commonInit()
    }

    override func updateViewConstraints() {

        if didSetupConstraints == false {

            self.scrollView.snp.makeConstraints({ (make) in
                make.edges.equalTo(self.view)
            })

            self.contentView.snp.makeConstraints({ (make) in
                make.edges.equalTo(self.scrollView)
            })

            var leftView:UIView? = nil
            for subview in self.contentView.subviews {

                subview.snp.makeConstraints({ (make) in
                    make.top.bottom.equalTo(self.contentView)

                    if leftView == nil {
                        make.left.equalTo(self.contentView)
                    }else{
                        make.left.equalTo(leftView!.snp.right)
                    }

                    if self.contentView.subviews.last == subview {
                        make.right.equalTo(self.contentView)
                    }
                })

                leftView = subview
            }

            self.scrollView.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView)
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

extension SplashPageViewController:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let viewControllers = tabBarController.viewControllers else {
            return
        }

        if viewControllers.first!.isEqual(viewController) {
            print("VIN Controller")
            UMEventsManager.Events.tapVINTab.count()
        }else{
            print("Report Controller")
            UMEventsManager.Events.tapReportTab.count()
        }
    }
}
