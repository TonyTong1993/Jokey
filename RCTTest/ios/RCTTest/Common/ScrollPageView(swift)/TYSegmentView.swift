//
//  TYSegmentView.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/21.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYSegmentView: UIView {
    
    private let titles : [String]
    
    private let normalTitleColor : UIColor
    
    private let seletedTitleColor : UIColor
    
    private var items : [TYSegmentItem]?
    
    func setupSegmentItems(titles:[String]) -> [TYSegmentItem] {
        var segmentItems :[TYSegmentItem] = []
        for title in titles {
            let segmentItem =  TYSegmentItem(title: title, normalTitleColor: normalTitleColor, selectedTitleColor: seletedTitleColor )
            segmentItems.append(segmentItem)
            addSubview(segmentItem)
        }
        return segmentItems
    }
    
    init(frame: CGRect,titles ts: [String],normalTitleColor ntc: UIColor,seletedTitleColor stc: UIColor) {
        seletedTitleColor = stc
        normalTitleColor = ntc
        titles = ts
        super.init(frame: frame)
        items = setupSegmentItems(titles: titles)
    }
    
    convenience init(frame: CGRect,ts: [String],ntc: UIColor,stc : UIColor) {
        self.init(frame: frame, titles: ts, normalTitleColor: ntc, seletedTitleColor: stc)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let items = items else {
            return
        }
        let width = frame.width / CGFloat(items.count)
        var index:CGFloat = 0
        for item in items {
            item.frame = CGRect(x: width*index, y: 0, width: width, height: frame.height)
            index += 1
        }
        
        
        
    }
    
}
