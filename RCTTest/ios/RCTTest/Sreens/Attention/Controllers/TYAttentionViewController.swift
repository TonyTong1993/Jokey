//
//  TYAttentionViewController.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/14.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYAttentionViewController: TYBaseViewController {
    
    private lazy var segmentView: TYSegmentView = {
        
        let segmentView = TYSegmentView(
                                        frame: CGRect(x: 0, y: 0, width: 200, height: 36),
                                        titles: ["关注","热点"],
                                        normalTitleColor: UIColor.textTint,
                                        seletedTitleColor: UIColor.themeTint)
        return segmentView
    }()
    let scrollView: UIScrollView = {
        
       let frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width , height: UIScreen.main.bounds.height-103)
        
        let scrView = UIScrollView(frame: frame)
        return scrView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加子视图
        let height = UIScreen.main.bounds.height-103
        let width = UIScreen.main.bounds.width
        scrollView.contentSize = CGSize(width: width*CGFloat(2), height: height)
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        view.addSubview(scrollView)
        for i in 0..<2 {
            let vc = TYCategaryViewController()
            vc.view.backgroundColor = UIColor.green
            vc.view.frame = CGRect(x: CGFloat(i)*width, y: 0, width: width, height: height)
            scrollView.addSubview(vc.view)
            addChildViewController(vc)
        }
        
    }

    override func setUpNavigationBar() {
        navigationItem.titleView = segmentView
    }
    

}

extension TYAttentionViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll")
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewWillEndDragging")
    }
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
    }
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
}
