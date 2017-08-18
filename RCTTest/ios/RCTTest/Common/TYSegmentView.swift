//
//  TYSegmentView.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/18.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYSegmentView: UIView {
    var normalColor = UIColor.black
    var selectedColor = UIColor.green
    
    
    private var titles : [String]
    private var scrollView : UIScrollView
    private var currentIndex : UInt8
    private var segmentItems : [TYSegmentItem]
    
    init(frame:CGRect,titles:[String],scrollView:UIScrollView,currentIndex:UInt8) {
        self.titles = titles
        self.scrollView = scrollView
        self.currentIndex = currentIndex
        segmentItems =  []
        let width = frame.size.width
        let height = frame.size.height
        let itemWidth = width / CGFloat(titles.count)
        var startX = 0
        var index = 0
        for title in titles {
            let segmentItem = TYSegmentItem(title: title, normalColor: normalColor, selectedColor: selectedColor)
            segmentItems.append(segmentItem)
        }
        super.init(frame: frame)
    }
    
    convenience init(frame:CGRect,ts:[String],sv:UIScrollView,cindex:UInt8) {
        self.init(frame: frame, titles: ts, scrollView: sv, currentIndex: cindex)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
