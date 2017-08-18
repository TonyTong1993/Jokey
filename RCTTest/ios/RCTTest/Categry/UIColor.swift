//
//  UIColor.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/18.
//  Copyright © 2017年 童万华. All rights reserved.
//

import Foundation
extension UIColor {
    public convenience init(hexValue:UInt64) {
        
        self.init(red: ((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(hexValue & 0xFF)) / 255.0, alpha: 1.0)
    }
}
