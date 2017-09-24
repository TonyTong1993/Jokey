//
//  TYSegmentScrollVIew.swift
//  RCTTest
//
//  Created by 童万华 on 17/9/23.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit
protocol TYSegmentScrollViewDataSource :NSObjectProtocol{
    func numberOfItem(segmentScrollView:UIView)->Int
    func titleForItem(segmentScrollView:UIView,index:Int)->String
}
class TYSegmentScrollVIew: UIScrollView {
    var normalTitleColor = UIColor.hex(0x33333) {
        didSet {
            
        }
    }
   
    
    var selectedTitleColor = UIColor.hex(themeColorHexValue) {
        didSet {
            
        }
    }
    
    weak var dataSource:TYSegmentScrollViewDataSource? {
        didSet {
            //创建视图
            guard let count = dataSource?.numberOfItem(segmentScrollView: self) else {
                return
            }
            var items = [TYSegmentItem]()
            var startX : CGFloat = 0
            
            for index in 0..<count {
                if let title = dataSource?.titleForItem(segmentScrollView: self, index: index) {
                    
                    let item = TYSegmentItem(title: title, normalTitleColor: normalTitleColor, selectedTitleColor: selectedTitleColor)
                    //设置item的尺寸及位置 edgeInset（5，5，5，5）
                    
                    let frame = CGRect(x: startX, y: 0, width: item.titleSize.width+10, height: item.titleSize.height+10)
                    item.frame = frame
                    startX = startX + item.titleSize.width+10
                    items.append(item)
                    addSubview(item)
                }
            }
            //如果有数据才添加
            if items.count > 0 {
                self.items = items
                self.contenSizeW = startX
            }
        }
    }
    
     var selectedIndex : UInt8?
    
    fileprivate var items : [TYSegmentItem]?
    fileprivate var contenSizeW : CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        bounces = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        if frame.width < contenSizeW {
            self.contentSize.width = contenSizeW
        }
        guard let items = items else {
            return
        }
        
        for item in items {
            item.center.y = self.center.y
        }
        
    }

}
