//
//  CustomKeyboardView.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/21.
//  Copyright © 2016年 daimler. All rights reserved.
//

/*
 let keys:String = "0123456789ABCDEFGHJKLMNPQRSTUVWXYZ"
 let rowKeyCount:[Int] = [10,7,6,6,5]
 */

import UIKit
import SwiftyButton
protocol CustomKeyboardViewDelegate {
    func didChangeContent(text:String,keyboard:CustomKeyboardView)
    func inputTextField(keyboard:CustomKeyboardView) -> UITextField
}
class CustomKeyboardView: UIView {

    private var didSetupConstraints      = false
    private var keys:String              = "0123456789ABCDEFGHJKLMNPQRSTUVWXYZ"
    private var rowKeyCount:[Int]        = [10,7,6,6,5]
    var rowKeyButtons:[[CGFloat:UIView]] = []

    let backSpaceButton:UIButton = CustomKeyboardView.initKeyCommand(title: "", imageName: "icon_backspace")
    let cancelButton:UIButton    = CustomKeyboardView.initKeyCommand(title: "取消")
    let doneButton:UIButton      = CustomKeyboardView.initKeyCommand(title: "完成")


    init(with keys:String,rowKeyCount:[Int],frame: CGRect) {
        super.init(frame: frame)

        var allCount = 0
        for keyCount in rowKeyCount {
            allCount = allCount + keyCount
        }

        //数据不一致
        if (allCount != keys.characters.count) {
            fatalError("init(keys: rowKeyCount: frmae) has not been implemented")
        }

        self.keys = keys
        self.rowKeyCount = rowKeyCount

        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.didSetupConstraints = false
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    var inputField:UITextField? {
        get{
            return self.delegate?.inputTextField(keyboard: self)
        }
    }
    var delegate:CustomKeyboardViewDelegate?

    func commonInit() {
        self.layer.cornerRadius  = KeyRow.keyCornerRadius
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.table_background

        var startIndex:Int = 0
        for count in rowKeyCount {

            let subString = (keys as NSString).substring(with: NSMakeRange(startIndex, count)) as String

            var strings:[String] = []

            for c in subString.characters {
                strings.append(String(c))
            }

            let row = KeyRow(keys: strings)
            for subview in row.subviews {
                if let button = subview as? UIButton {
                    button.addTarget(self, action: #selector(keyAction(button:)), for: .touchUpInside)
                }
            }
            self.addSubview(row)

            var per = CGFloat(count)/7.0
            if per > 1 {
                per = 1
            }
            rowKeyButtons.append([per:row])

            startIndex += count
        }

        self.addSubview(self.backSpaceButton)
//        self.addSubview(self.cancelButton)
//        self.addSubview(self.doneButton)

        self.backSpaceButton.addTarget(self, action: #selector(backspaceAction), for: .touchUpInside)

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(backspaceExtenionAction))
        self.backSpaceButton.addGestureRecognizer(longPress)

        self.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        self.doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)

        self.updateConstraintsIfNeeded()
    }

    override func updateConstraints(){
        if (!didSetupConstraints){

            let padding:CGFloat = 2

            var topView:UIView?  = nil

            for item:[CGFloat:UIView] in rowKeyButtons {

                let row = item.values.first!
                let per = item.keys.first!

                let isLastRow = (rowKeyButtons.last! == item)

                row.snp.makeConstraints({ (make) in

                    if topView == nil {
                        make.top.equalTo(self).offset(padding)
                    }else{
                        make.top.equalTo(topView!.snp.bottom).offset(padding)
                        make.height.equalTo(topView!)
                    }

                    make.width.equalTo(self).multipliedBy(per)

                    if isLastRow == true {
                        make.bottom.equalTo(self).offset(-padding)
                        make.left.equalTo(topView!)
                    }
                    else{
                         make.centerX.equalTo(self)
                    }
                })

                topView = row
            }

            if let row5 = self.rowKeyButtons[4].values.first {
                backSpaceButton.snp.makeConstraints({ (make) in
                    make.left.equalTo(row5.snp.right).offset(padding)
                    make.right.equalTo(self).offset(-2 * padding)
                    make.top.bottom.equalTo(row5)
                })
            }

//            if let row6 = self.rowKeyButtons.last?.values.first {
//                doneButton.snp.makeConstraints({ (make) in
//                    make.left.equalTo(row6.snp.right).offset(padding)
//                    make.right.equalTo(self).offset(-padding)
//                    make.top.bottom.equalTo(row6)
//                })
//
//                cancelButton.snp.makeConstraints({ (make) in
//                    make.left.equalTo(self).offset(padding)
//                    make.right.equalTo(row6.snp.left).offset(-padding)
//                    make.top.bottom.equalTo(row6)
//                })
//            }
//

            didSetupConstraints = true
        }

        super.updateConstraints()
    }

    func keyAction(button:UIButton){

        guard let textField = self.inputField else {
            return
        }

        guard let key = button.title(for: .normal) else {
            return
        }

        guard let text = textField.text else {
            textField.text = key;
            return    
        }

        textField.text = text + key

        self.delegate?.didChangeContent(text: textField.text ?? "", keyboard: self)
    }
    func backspaceAction(){
        guard let textField = self.inputField else {
            return
        }

        guard let text = textField.text else {
            return
        }

        if text.characters.count > 0 {
            textField.text = text.substring(to: text.characters.count - 1)
        }

        self.delegate?.didChangeContent(text: textField.text ?? "", keyboard: self)
    }
    func backspaceExtenionAction(){

        backspaceAction()
    }

    func cancelAction(){

    }

    func doneAction() {

    }


    static func initKeyCommand(title:String,imageName:String? = nil) -> UIButton {

        let button = SwiftyButton()

        button.cornerRadius     = 5
        button.shadowHeight     = 0
        button.buttonColor      = UIColor.lightGray
        button.highlightedColor = UIColor.black

        button.setTitle(title, for: .normal)
        if (imageName != nil){
            button.setImage(UIImage(named:imageName!), for: .normal)
        }
        return button
    }
}
