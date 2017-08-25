//
//  TYSegmentItem.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/21.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYSegmentItem: UIButton {
     var segmentIndex = 0
     var titleSize : CGSize = CGSize.zero
    
     init(title: String,normalTitleColor: UIColor,selectedTitleColor: UIColor) {
        super.init(frame: CGRect())
        setTitle(title, for: .normal)
        setTitleColor(normalTitleColor, for: .normal)
        setTitleColor(selectedTitleColor, for: .selected)
        guard let font = UIFont(name: TYTheme.themeFontFamilyName(), size: 16) else {
            return
        }
        titleLabel?.font = font
        titleSize = title.size(attributes: [NSFontAttributeName:font])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String,nc: UIColor,sc: UIColor) {
        self.init(title: title, normalTitleColor: nc, selectedTitleColor: sc)
    }
 

}
