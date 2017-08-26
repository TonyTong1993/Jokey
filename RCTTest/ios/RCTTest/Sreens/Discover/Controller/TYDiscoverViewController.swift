//
//  TYDiscoverViewController.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/14.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYDiscoverViewController: TYBaseViewController {
    lazy var searchView: SearchView = {
      
        return  SearchView(frame:CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height: 40))
      
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
      
       navigationItem.titleView = searchView

    }
    



}
