//
//  UCPageViewController.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/23.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit

class UCPageViewController: UIPageViewController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        for gesture in self.gestureRecognizers {
            gesture.delegate = self
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchView = touch.view else {
            return true
        }

        return touchView.isKind(of: UIControl.classForCoder()) == false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
