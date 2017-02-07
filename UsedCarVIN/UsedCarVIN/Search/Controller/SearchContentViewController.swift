//
//  SearchContentViewController.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/19.
//  Copyright © 2016年 daimler. All rights reserved.
//

import UIKit
import SwiftyButton

protocol SearchResultsProtocol:NSObjectProtocol {
    func searchedResult(model:VehicleModel,searchViewController:SearchContentViewController)
}

class SearchContentViewController: BaseViewController {

    var delegate:SearchResultsProtocol?

    var inputDescription: String {
        set{
            self.inputDescriptionLabel.text = newValue
        }
        get{
            return self.inputDescriptionLabel.text!
        }
    }

    var actionNormalImageName: String{
        set{
            self.actionButton.setImage(UIImage.init(named: newValue), for: .normal)
        }
        get{
            return ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNeedsStatusBarAppearanceUpdate()


        self.actionButton.addTarget(self, action: #selector(action), for: .touchUpInside)
        self.searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
    }

    override func commonInit() {
        self.view.addSubview(inputContentView)
        self.view.addSubview(inputDescriptionLabel)
        self.view.addSubview(actionButton)
        self.view.addSubview(searchButton)

        self.view.setNeedsUpdateConstraints()
    }

    func action() {
        print("button.Action")
    }

    func search() {
        print("search")
    }

    override func updateViewConstraints() {

        if (!didSetupConstraints) {

            let superview = self

            let vPadding:CGFloat = 20
            let height:CGFloat   = 40

            inputContentView.snp.makeConstraints { make in
                make.top.equalTo(60)
                make.left.equalTo(superview.view).offset(vPadding)
                make.right.equalTo(superview.view).offset(-vPadding)
                make.height.equalTo(height)
            }

            inputDescriptionLabel.snp.makeConstraints { make in
                make.left.equalTo(superview.inputContentView)
                make.top.equalTo(superview.inputContentView.snp.bottom).offset(30)
                make.width.equalTo(superview.inputContentView)
                make.height.equalTo(20)
            }

            actionButton.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 80, height: 80))
                make.centerX.equalTo(superview.view)
                make.top.equalTo(superview.inputDescriptionLabel.snp.bottom).offset(30)
            }

            searchButton.snp.makeConstraints { make in
                make.height.equalTo(height)
                make.bottom.equalTo(superview.view).offset(-40)
                make.centerX.equalTo(superview.view)
                make.left.equalTo(superview.view).offset(vPadding)
                make.right.equalTo(superview.view).offset(-vPadding)
            }
            didSetupConstraints = true
        }

        super.updateViewConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    func validate(textControl:ValidationProtocol){
        do {
            try self.searchButton.isEnabled = textControl.validate()
        } catch let ex {
            print(ex)
            self.searchButton.isEnabled = false
        }
    }

    let inputContentView:UIView = {
        let contentView = UIView()
        return contentView
    }()

    let inputDescriptionLabel:UILabel = {
        let label           = UILabel()
        label.textColor     = UIColor.lightGray
        label.textAlignment = .center
        label.font          = UIFont.systemFont(ofSize: 12)
        return label
    }()

    let actionButton:UIButton  = {
        let button = UIButton(type: .custom)
        return button
    }()

    let searchButton:UIButton = {
        let button = SwiftyButton()
        button.cornerRadius        = 5
        button.buttonColor         = UIColor.black
        button.disabledButtonColor = UIColor.lightGray
        button.buttonPressDepth    = 0.8
        button.shadowHeight        = 0
        button.isEnabled           = false

        button.setTitle("查询", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()

}

