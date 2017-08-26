//
//  SearchView.swift
//  RCTTest
//
//  Created by 童万华 on 17/8/25.
//  Copyright © 2017年 童万华. All rights reserved.
//

import Foundation

class SearchView: UIView {
    let searchBar: UISearchBar
    let rightItem : UIButton
    
    override init(frame: CGRect) {
        searchBar = UISearchBar()
        
        //设置searchBar的style
//        searchBar.barStyle = .black
//        searchBar.isTranslucent = true
//        searchBar.prompt = "解释："
        searchBar.tintColor = UIColor.orange
        searchBar.barTintColor = UIColor.red
        searchBar.searchBarStyle = .minimal
//        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//        inputView.backgroundColor = UIColor.red
//       searchBar.inputAccessoryView = inputView
//         searchBar.backgroundImage =   UIImage.singleLineImage(with: UIColor.blue)
//        searchBar.setPositionAdjustment(UIOffsetMake(100, 0.0), for: .search)
//        print(searchBar.positionAdjustment(for: .search))
        
        searchBar.placeholder = "搜索你想要的内容"
//        searchBar.searchFieldBackgroundPositionAdjustment = UIOffsetMake(-50, 0.0)
//        searchBar.searchTextPositionAdjustment = UIOffsetMake(-50, 0.0)
        rightItem = UIButton()
        super.init(frame: frame)
        
        addSubview(searchBar)
        addSubview(rightItem)
        rightItem.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rightItem.snp.updateConstraints { (maker) in
            maker.right.equalTo(self.snp.right).offset(-10)
            maker.height.equalTo(28)
            maker.width.equalTo(28)
            maker.centerY.equalToSuperview()
        }
        
        searchBar.snp.updateConstraints { (maker) in
            maker.left.equalTo(self.snp.left).offset(10)
            maker.right.equalTo(rightItem.snp.left).offset(-10)
            maker.height.equalTo(28)
            maker.centerY.equalToSuperview()
        }
        
    }
    
}
