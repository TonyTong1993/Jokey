//
//  TYSegmentView.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/21.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit
protocol TYSegmentViewDelegate : NSObjectProtocol{
   func segmentViewItemClicked(segmentItem:TYSegmentItem)
}
class TYSegmentView: UIView {
    
    private let titles : [String]
    
    private let normalTitleColor : UIColor
    
    private let seletedTitleColor : UIColor
    
    private var items : [TYSegmentItem]?
    
    private var currentIndex: Int = 0
    
    lazy var indicatorView: UIView = {
        let indicatorView = UIView(frame: CGRect())
        return indicatorView
    }()
    
    
    weak var delegate : TYSegmentViewDelegate?
    
    fileprivate  var selectedRgbaComponents: [CGFloat]?
    
    fileprivate var normalRgbaComponents: [CGFloat]?
    
    fileprivate var deltaRgbaComponents : [CGFloat]?
    
    fileprivate  var indicatorViewWidth : CGFloat?
    
    fileprivate var detalTitleSizeW : CGFloat?
    
    func setupSegmentItems(titles:[String]) -> [TYSegmentItem] {
        var segmentItems :[TYSegmentItem] = []
        for title in titles {
            let segmentItem =  TYSegmentItem(title: title, normalTitleColor: normalTitleColor, selectedTitleColor: seletedTitleColor)
            segmentItem.addTarget(self, action: #selector(handleSegmentItemClicked(segmentItem:)), for: .touchUpInside)
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
        
        //更新默认选中项
        items?.first?.isSelected = true
        //设置指示器的宽度

        indicatorViewWidth = items?.first?.titleSize.width
        indicatorView.frame = CGRect(x: 0, y: frame.height-2, width: indicatorViewWidth ?? 0.0, height: 2)
        indicatorView.backgroundColor = seletedTitleColor
        addSubview(indicatorView)
        selectedRgbaComponents = seletedTitleColor.rgba()
        normalRgbaComponents = normalTitleColor.rgba()
        deltaRgbaComponents = UIColor.gradientRGBA(normalRgbaComponents: normalRgbaComponents,selectedRgbaComponents: selectedRgbaComponents)
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
            item.segmentIndex = Int(index)
            index += 1
        }
        
        //更新指示器视图的默认位置
        let currentItem = items[currentIndex]
        indicatorView.center.x = currentItem.center.x
    
        
    }
    @objc func handleSegmentItemClicked(segmentItem:TYSegmentItem) {
        if segmentItem.segmentIndex != currentIndex {
            let preSegmenItem = items![currentIndex]
            preSegmenItem.isSelected = false
            let lastSegmentItem = segmentItem
            lastSegmentItem.isSelected = true
            delegate?.segmentViewItemClicked(segmentItem: segmentItem)
            currentIndex = segmentItem.segmentIndex
            updateSegmentItemState(segmentItem: segmentItem)
        }
    }
    
    //pramrk------更新segmentItem状态
   @objc func updateSegmentItemState(segmentItem:TYSegmentItem)  {
        guard let font = UIFont(name: TYTheme.themeFontFamilyName(), size: 16) else {
            return
        }
         let titleSize = titles[segmentItem.segmentIndex].size(attributes: [NSFontAttributeName:font])
         let orgin = indicatorView.frame.origin
         UIView.animate(withDuration: 0.25) {
            self.indicatorView.frame = CGRect(x: orgin.x, y: orgin.y, width: titleSize.width, height: 2)
            self.indicatorView.center.x = segmentItem.center.x
        }
    }
    
    //prmark----更新scrollView滚动时，segmentView状态的变化
    func updateSegmentViewState(scale:CGFloat)  {
        //边界计算
        let count = CGFloat(titles.count)
        if scale >= count-1 {
            return
        }
        if scale <= 0 {
            return
        }
        
        let leftIndex = Int(scale)
        let rightIndex = leftIndex+1
        let scaleRight = scale - CGFloat(leftIndex)
        let scaleLeft = 1 - scaleRight
        if scaleLeft == 1 && scaleRight == 0 {
            return
        }
        
        let leftItem = items![leftIndex]
        var rightItem : TYSegmentItem?
        
        if rightIndex < Int(count) {
            rightItem = items![rightIndex]
        }
        //更新指示器的策略
//        CGRect frame = self.itemSelectedBgImageView.frame;
//        
//        CGFloat xDiff = rightItem.frameWithOutTransform.origin.x - leftItem.frameWithOutTransform.origin.x;
//        frame.origin.x = rightScale * xDiff + leftItem.frameWithOutTransform.origin.x + self.itemSelectedBgInsets.left;
//        
//        CGFloat widthDiff = rightItem.frameWithOutTransform.size.width - leftItem.frameWithOutTransform.size.width;
//        if (widthDiff != 0) {
//            CGFloat leftSelectedBgWidth = leftItem.frameWithOutTransform.size.width - self.itemSelectedBgInsets.left - self.itemSelectedBgInsets.right;
//            frame.size.width = rightScale * widthDiff + leftSelectedBgWidth;
//        }
//        self.itemSelectedBgImageView.frame = frame;
//        let width = leftItem.titleSize.width + ((rightItem?.titleSize.width ?? 0) - leftItem.titleSize.width)*scaleRight
//        indicatorView.bounds = CGRect(origin: CGPoint.zero, size:CGSize(width: width, height: 2))
       
        let originalY = indicatorView.center.y;
        let centerX = leftItem.center.x + ((rightItem?.center.x ?? 0) - leftItem.center.x) * scaleRight;
        indicatorView.center = CGPoint(x: centerX, y: originalY)
        
    
        //添加渐变颜色
       setupGradient(value: Int(scale), leftItem: leftItem, rightItem: rightItem, scale: scaleRight)
    }
    func setupGradient(value: Int,leftItem: TYSegmentItem,rightItem:TYSegmentItem?,scale: CGFloat)  {
        if value > currentIndex || value == currentIndex {
            leftItem.setTitleColor(UIColor.transfromToNormalColor(selectedRgbaComponents: selectedRgbaComponents,deltaRGBA: deltaRgbaComponents,scale: scale), for: .selected)
            rightItem?.setTitleColor(UIColor.transfromToSelectedColor(normalRgbaComponents: normalRgbaComponents, deltaRGBA: deltaRgbaComponents, scale: scale), for: .normal)
        }else {
            leftItem.setTitleColor(UIColor.transfromToNormalColor(selectedRgbaComponents: selectedRgbaComponents,deltaRGBA: deltaRgbaComponents,scale: scale), for: .normal)
            rightItem?.setTitleColor(UIColor.transfromToSelectedColor(normalRgbaComponents: normalRgbaComponents, deltaRGBA: deltaRgbaComponents, scale: scale), for: .selected)
            
        }
    }
    func updateSegmentItemState(index:Int)  {
        if currentIndex != index {
            guard let font = UIFont(name: TYTheme.themeFontFamilyName(), size: 16),
                let items = items else {
                    return
            }
            let preItem = items[currentIndex]
            preItem.isSelected = false
            
            let currentItem = items[index]
            currentItem.isSelected = true
            currentIndex = index
            
            //fIXME:动态更新指示器的width
            let titleSize = titles[index].size(attributes: [NSFontAttributeName:font])
            let orgin = indicatorView.frame.origin
            self.indicatorView.frame = CGRect(x: orgin.x, y: orgin.y, width: titleSize.width, height: 2)
            self.indicatorView.center.x = currentItem.center.x
        }
        
        for item in items ?? []  {
            item.setTitleColor(normalTitleColor, for: .normal)
            item.setTitleColor(seletedTitleColor, for: .selected)
        }
    }
}

