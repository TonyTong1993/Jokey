//
//  SearchView.swift
//  RCTTest
//
//  Created by 童万华 on 17/8/25.
//  Copyright © 2017年 童万华. All rights reserved.
//

import Foundation

class SearchView: UIView {
    enum HandleCallBackType {
        case search
        case add
    }
    var handleTapGestureBlock:(_ eventType:HandleCallBackType)->()?
    
    init(frame:CGRect,callBack:@escaping (_ eventType:HandleCallBackType)->()) {

        handleTapGestureBlock = callBack
        super.init(frame: frame)
        //布局视图
        let likeInputView = UIView()
        likeInputView.backgroundColor = UIColor.hex(0xDCDDE0)
        likeInputView.layer.cornerRadius = 2;
        likeInputView.layer.masksToBounds = true;

        //添加点击事件
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        likeInputView.addGestureRecognizer(tapGesture)

       let searchIcon = UIImage(named: "nav_search")
       let searchView = UIImageView(image: searchIcon)

        let placeLabel = UILabel()
        placeLabel.text = "搜索话题／帖子／用户"
        placeLabel.textColor = UIColor.hex(0x999999)
        placeLabel.font = UIFont(name: TYTheme.themeFontFamilyName(), size: 14)
        placeLabel.sizeToFit()
        likeInputView.addSubview(searchView)
        likeInputView.addSubview(placeLabel)
        //使用snap布局
        searchView.snp.updateConstraints { (make) in
            make.centerY.equalTo(likeInputView.snp.centerY)
            make.left.equalTo(likeInputView.snp.left).offset(10)
        }
        placeLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(searchView.snp.right).offset(10)
            maker.centerY.equalTo(likeInputView.snp.centerY)
        }

        let addBtn = UIButton()
        //添加点击事件
        addBtn.addTarget(self, action: #selector(handleAddClicked), for: .touchUpInside)
        //添加样式
        let icon = UIImage(named:"nav_add");
        addBtn.setImage(icon, for: .normal)
        addBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 3, 7, 3)//图片视图的padding
        addBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)//按钮视图的padding

        let stackView = UIStackView(frame: frame)
        stackView.addArrangedSubview(likeInputView)
        stackView.addArrangedSubview(addBtn)
        stackView.spacing = 10
        addSubview(stackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("deallco")
    }
    /*privite method*/
    func handleTapGesture()  {
       handleTapGestureBlock(.search)
    }
    func handleAddClicked()  {
        handleTapGestureBlock(.add)
    }
    
}
/*
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
 */
