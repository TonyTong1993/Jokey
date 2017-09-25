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
            guard let items = items else {
                return
            }
            for item in items {
                item.setTitleColor(normalTitleColor, for: .normal)
            }
        }
    }
   
    
    var selectedTitleColor = UIColor.hex(themeColorHexValue) {
        didSet {
            indicateView.backgroundColor = selectedTitleColor
            guard let items = items else {
                return
            }
            for item in items {
                item.setTitleColor(normalTitleColor, for: .normal)
            }
        }
    }
    
    fileprivate var indicateView = UIView()
    
    weak var dataSource:TYSegmentScrollViewDataSource? {
        didSet {
            //创建视图
            guard let count = dataSource?.numberOfItem(segmentScrollView: self) else {
                return
            }
            var items = [TYSegmentItem]()
            
            let padding : CGFloat = 5.0
            var startX : CGFloat = padding
            for index in 0..<count {
                if let title = dataSource?.titleForItem(segmentScrollView: self, index: index) {
                    
                    let item = TYSegmentItem(title: title, normalTitleColor: normalTitleColor, selectedTitleColor: UIColor.white)
                    item.segmentIndex = index
                    item.addTarget(self, action: #selector(handleItemClicked(item:)), for: .touchUpInside)
                    //设置item的尺寸及位置 edgeInset（5，5，5，5）
                    
                    let frame = CGRect(x: startX, y: 0, width: item.titleSize.width+16, height: item.titleSize.height+10)
                    item.frame = frame
                    startX = startX + item.titleSize.width+16 + padding
                    items.append(item)
                   
                    addSubview(item)
                }
            }
            //如果有数据才添加
            if items.count > 0 {
                self.items = items
                self.contenSizeW = startX
                let index = selectedIndex
                
                //设置默认选中项
                let selectedItem = items[index]
                indicateView.backgroundColor = selectedTitleColor
                indicateView.layer.cornerRadius = selectedItem.titleSize.height/2
                indicateView.layer.masksToBounds = true
                updateIndicatorView(index: index)
                
            }
        }
    }
    var currentIndex : Int = 0
    var selectedIndex : Int {
        get {
            return currentIndex
        }
        set {
            //还原原视图
            guard let items = items else {
                return
            }
            if currentIndex == newValue {
                return
            }
            let currentItem = items[currentIndex]
            currentItem.isSelected = false
            currentIndex = newValue
            //更新
            updateIndicatorView(index: currentIndex)
        }
        
    }
    
    fileprivate var items : [TYSegmentItem]?
    fileprivate var contenSizeW : CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        addSubview(indicateView)
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
    
    @objc func handleItemClicked(item:TYSegmentItem) {
        selectedIndex = item.segmentIndex
    }
    @objc func updateIndicatorView(index:Int) {
        guard let items = items else {
            return
        }
        let selectedItem = items[index]
        selectedItem.isSelected = true
        //设置指示器视图
        indicateView.snp.remakeConstraints({ (maker) in
            maker.centerY.equalTo(selectedItem.snp.centerY)
            maker.centerX.equalTo(selectedItem.snp.centerX)
            maker.width.equalTo(selectedItem.frame.width)
            maker.height.equalTo(selectedItem.titleSize.height)
        })
     
        //将按钮居中显示
        let midX = selectedItem.frame.midX
        if frame.width == 0 {
            return
        }
        
        if midX > frame.width/2  {
            let deltaX = midX - contentOffset.x - frame.width/2
            let currentContentOffsetX = contentOffset.x
            var expContentOffsetX = currentContentOffsetX + deltaX
            let width = expContentOffsetX + frame.width
            if (width > contenSizeW) {
                expContentOffsetX = contenSizeW - frame.width
            }
            let expContentOffsetY = contentOffset.y
            setContentOffset( CGPoint(x: expContentOffsetX, y: expContentOffsetY), animated: true)
        }
      
    }

}
