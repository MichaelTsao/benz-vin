//
//  ViewController.swift
//  testSwift
//
//  Created by DreamTeamAAn on 2017/2/8.
//  Copyright © 2017年 TeamA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        circle.layer.masksToBounds = true
        circle.layer.cornerRadius = 50
        circle.backgroundColor = UIColor.blue
        circle.clipsToBounds = true
        
        
        
//        make.left.equalTo(20)
//        make.top.equalTo(bgView.snp.top).offset(50)
//        make.height.equalTo(30)
//        make.width.equalTo(30)
        
        
        
        //        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        //        let blurView = UIVisualEffectView(effect: darkBlur)
        //
        //        blurView.frame = circle.bounds
        //
        //        circle.addSubview(blurView)
        
        
        
//        circle.left.equalTo(20)
////        circle.top.equalTo(bgView.snp.top).offset(50)
//        circle.height.equalTo(30)
//        circle.width.equalTo(30)
        
        
        

        
        
        self.view.addSubview(circle)
    
        
//        circle.snp.top.equalTo(self.view.snp.top)

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

