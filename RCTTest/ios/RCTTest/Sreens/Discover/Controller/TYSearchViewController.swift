//
//  TYSearchViewController.swift
//  RCTTest
//
//  Created by 童万华 on 17/9/23.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYSearchViewController: TYBaseViewController {

    lazy var searchView: SearchView = {
        let frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width-20, height: 32)
        let searchView = SearchView.init(frame: frame,
                                         callBack: { eventType in
                                            let vc = UIViewController()
                                            
                                            if (eventType == .search) {
                                               
                                            }else {
                                                vc.title = "添加关注"
                                            }
                                            self.navigationController?.pushViewController(vc, animated: true)
        })
        return searchView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchView
        
    }

}
