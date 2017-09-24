//
//  TYTopicBanner.swift
//  RCTTest
//
//  Created by 童万华 on 17/9/23.
//  Copyright © 2017年 童万华. All rights reserved.
//segmentView + scrollView

import UIKit

class TYTopicBanner: UIView ,TYSegmentScrollViewDataSource{

   lazy var segmentView : TYSegmentScrollVIew = TYSegmentScrollVIew()
    let dataSource = ["热门","搞笑","娱乐","互动","情感","萌物","资源","校园","动漫","科技","才艺","游戏","老司机"]
    
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        
        //设置segmentView
        segmentView.dataSource = self
        //设置右边按钮
        let rightBtn = UIButton()
        
        //添加stackView
        let stackView = UIStackView(frame: frame)
        stackView.addArrangedSubview(segmentView)
        stackView.addArrangedSubview(rightBtn)
        
        addSubview(stackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK----TYSegmentScrollViewDataSource
    
    func numberOfItem(segmentScrollView: UIView) -> Int {
        return dataSource.count
    }
    
    func titleForItem(segmentScrollView: UIView, index: Int) -> String {
        return dataSource[index]
    }
}
