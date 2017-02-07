//
//  UIColor+EXT.swift
//  UsedCarVIN
//
//  Created by aquilx on 2016/12/20.
//  Copyright © 2016年 daimler. All rights reserved.
//

import Foundation
import UIKit
import UIColor_Hex_Swift

extension UIColor {

    open class var table_background: UIColor { get{

        return UIColor.init("#F2F2F2")
    }}

    open class var table_new_background: UIColor { get{
        
        return UIColor.init("#F1F1F1")
        }}
    
    
//    164	176	190	
    open class var label_tip_color: UIColor { get{
        return UIColor.init("#A4B0BE")
        }}
    
    
    //    0 0 0
    open class var label_text_color: UIColor { get{
        return UIColor.init("#000000")
        }}
    
    //
    open class var title_label_text_color: UIColor { get{
        return UIColor.init("#6C6C6C")
        }}
    
    //    蓝色 41	144	216
    open class var circular_label_text_color: UIColor { get{
        return UIColor.init("#2990D8")
        }}
    
    //    深灰色
    open class var night_background_color: UIColor { get{
        return UIColor.init("#2A2F36")
        }}
    
    
    open class var nav_black: UIColor { get{
        return UIColor.init(red: 36.0/255.0, green: 36.0/255.0, blue: 36.0/255.0, alpha: 1.0)
    }}
}
