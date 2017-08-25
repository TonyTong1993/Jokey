//
//  String(Add).swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/22.
//  Copyright © 2017年 童万华. All rights reserved.
//

import Foundation

extension String {
    func size(attributes:[String:Any]?) -> CGSize{
        let string = self as NSString
        return  string.boundingRect(with:  CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)),
                                    options:[.usesLineFragmentOrigin,.usesFontLeading],
                                    attributes: attributes, context: nil).size
        
    }
    
}
