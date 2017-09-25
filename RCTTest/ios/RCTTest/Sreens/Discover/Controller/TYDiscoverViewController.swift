//
//  TYDiscoverViewController.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/14.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYDiscoverViewController: TYBaseViewController,SDCycleScrollViewDelegate {
    lazy var searchView: SearchView = {
      let frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width-20, height: 32)
      let searchView = SearchView.init(frame: frame,
                                       callBack: { [weak self] eventType in
                                                    let vc = TYSearchViewController()
                                        
                                                    if (eventType == .search) {
                                                        vc.title = "搜索"
                                                    }else {
                                                         vc.title = "添加关注"
                                                    }
                                        self?.navigationController?.pushViewController(vc, animated: true)
      })
      return searchView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
      
       navigationItem.titleView = searchView
        
        setUpTableView()
    
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        
        //设置tableViewHeader轮播图组建
        let width = view.frame.width
        let frame = CGRect(x: 0, y: 0, width: width, height: 210)
        let cycleScrollView = SDCycleScrollView(frame: frame, delegate: self, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        
        cycleScrollView?.imageURLStringsGroup = [
        "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2431525477,3308925210&fm=27&gp=0.jpg",
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1506187561640&di=6530ac637613566ddb3b6ae1473c65ae&imgtype=0&src=http%3A%2F%2Fpic6.wed114.cn%2F20111112%2F20111112094300291498.jpg",
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1506187585390&di=24072d34676b1bd7de56cfd695cf2204&imgtype=0&src=http%3A%2F%2Fimg2.ph.126.net%2F19-XSSNBv1SuUMxyEqWD4w%3D%3D%2F3881821403817452153.jpg"
        ]
        cycleScrollView?.autoScrollTimeInterval = 3.0
        tableView.tableHeaderView = cycleScrollView
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let width = view.frame.width
        return TYTopicBanner(frame: CGRect(x: 0, y: 0, width: width, height: 40))
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
