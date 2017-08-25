//
//  TYAttentionViewController.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/14.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYAttentionViewController: TYBaseViewController,TYSegmentViewDelegate {
    
     lazy var segmentView: TYSegmentView = {
        
        let segmentView = TYSegmentView(
            frame: CGRect(x: 0, y: 0, width: 200, height: 44),
            titles: ["话题","右友圈"],
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
        segmentView.delegate = self
        //segmentView.layer.cornerRadius
    }
    
    func segmentViewItemClicked(segmentItem: TYSegmentItem) {
        let width = UIScreen.main.bounds.width
        let point = CGPoint(x: width*CGFloat(segmentItem.segmentIndex), y: 0)
        scrollView.setContentOffset(point, animated: false)
        

        
    }

 
}

extension TYAttentionViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scale = scrollView.contentOffset.x/scrollView.frame.width
        segmentView.updateSegmentViewState(scale: scale)
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       
    }
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.frame.width)
        segmentView.updateSegmentItemState(index: index)
    }
}
