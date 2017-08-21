//
//  TYAttentionViewCell.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/17.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYAttentionViewCell: UITableViewCell {

    
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var titlelabel: UILabel = {
        let titleLabel = UILabel()
        let font = TYTheme.themeFontFamilyName()!
        titleLabel.font = UIFont(name: font, size: 15)
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    lazy var rightLabel: UILabel = {
        let rightLabel = UILabel()
        let font = TYTheme.themeFontFamilyName()!
        rightLabel.font = UIFont(name: font, size: 10)
        rightLabel.textColor = UIColor.white
        rightLabel.textAlignment = .center
        rightLabel.backgroundColor = UIColor(hex: NSInteger(themeColorHexValue))
        rightLabel.layer.cornerRadius = 10
        rightLabel.layer.masksToBounds = true
        
        return rightLabel
    }()
    
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
       
       
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconView)
        contentView.addSubview(titlelabel)
        contentView.addSubview(rightLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension TYAttentionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        //布局头像
       let iconViewWidthConstraint = NSLayoutConstraint(item: iconView,
                                                        attribute: .width,
                                                        relatedBy: .equal,
                                                        toItem: nil,
                                                        attribute: .notAnAttribute,
                                                        multiplier: 1.0,
                                                        constant: 36)
       let iconViewHeigthConstraint = NSLayoutConstraint(item: iconView,
                                                         attribute: .height,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 36)
       let iconViewLeftConstraint = NSLayoutConstraint(item: iconView,
                                                       attribute: .left,
                                                       relatedBy: .equal,
                                                       toItem: self.contentView,
                                                       attribute: .left,
                                                       multiplier: 1.0,
                                                       constant: 20)
      let iconViewCenterYConstraint = NSLayoutConstraint(item: iconView,
                                                         attribute: .centerY,
                                                         relatedBy: .equal,
                                                         toItem: self.contentView,
                                                         attribute: .centerY,
                                                         multiplier: 1.0,
                                                         constant: 0)
    iconView.translatesAutoresizingMaskIntoConstraints = false;
    iconView.addConstraints([iconViewWidthConstraint,iconViewHeigthConstraint])
    addConstraints([iconViewLeftConstraint,iconViewCenterYConstraint])
        //布局标题
        let titlelabelLeftConstraint = NSLayoutConstraint(item: titlelabel,
                                                        attribute: .left,
                                                        relatedBy: .equal,
                                                        toItem: iconView,
                                                        attribute: .right,
                                                        multiplier: 1.0,
                                                        constant: 20)
        let titlelabelCenterYConstraint = NSLayoutConstraint(item: titlelabel,
                                                           attribute: .centerY,
                                                           relatedBy: .equal,
                                                           toItem: self.contentView,
                                                           attribute: .centerY,
                                                           multiplier: 1.0,
                                                           constant: 0)
        titlelabel.translatesAutoresizingMaskIntoConstraints = false;
      addConstraints([titlelabelLeftConstraint,titlelabelCenterYConstraint])
        //布局右边详情信息
        
        let rightlabelidthConstraint = NSLayoutConstraint(item: rightLabel,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 64)
        let rightlabelHeigthConstraint = NSLayoutConstraint(item: rightLabel,
                                                          attribute: .height,
                                                          relatedBy: .equal,
                                                          toItem: nil,
                                                          attribute: .notAnAttribute,
                                                          multiplier: 1.0,
                                                          constant: 20)
        rightLabel.addConstraints([rightlabelidthConstraint,rightlabelHeigthConstraint])
        
        let rightlabelLeftConstraint = NSLayoutConstraint(item: rightLabel,
                                                          attribute: .right,
                                                          relatedBy: .equal,
                                                          toItem: self.contentView,
                                                          attribute: .right,
                                                          multiplier: 1.0,
                                                          constant: -20)
        let rightlabelCenterYConstraint = NSLayoutConstraint(item: rightLabel,
                                                             attribute: .centerY,
                                                             relatedBy: .equal,
                                                             toItem: self.contentView,
                                                             attribute: .centerY,
                                                             multiplier: 1.0,
                                                             constant: 0)
        rightLabel.translatesAutoresizingMaskIntoConstraints = false;
        addConstraints([rightlabelLeftConstraint,rightlabelCenterYConstraint])
    }
}
