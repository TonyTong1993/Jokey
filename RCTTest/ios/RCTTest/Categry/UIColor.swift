//
//  UIColor.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/18.
//  Copyright © 2017年 童万华. All rights reserved.
//

import Foundation
extension UIColor {
    public convenience init(hex:NSInteger,alpha:CGFloat=1.0) {
        
        self.init(red: ((CGFloat)((hex & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(hex & 0xFF)) / 255.0, alpha: alpha)
    }
    class func hex(_ hex:NSInteger,alpha : CGFloat = 1.0)->UIColor {
        return UIColor(red: ((CGFloat)((hex & 0xFF0000) >> 16))/255.0,
                       green: ((CGFloat)((hex & 0xFF00) >> 8))/255.0,
                       blue: ((CGFloat)(hex & 0xFF))/255.0, alpha: alpha)
    }
}
