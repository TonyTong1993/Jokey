//
//  TYSegmentItem.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/18.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYSegmentItem: UIButton {
    var indexInSegmentView = 0
    
    init(title:String,normalColor:UIColor,selectedColor:UIColor) {
         super.init(frame: CGRect.zero)
        setTitle(title, for: .normal)
        setTitleColor(normalColor, for: .normal)
        setTitleColor(selectedColor, for: .selected)
        
    }
    convenience init(title:String,nc:UIColor,sc:UIColor) {
        self.init(title: title, normalColor: nc, selectedColor: sc)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  

}
