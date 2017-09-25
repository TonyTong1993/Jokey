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
        loadNewData()
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        
        //设置tableViewHeader轮播图组建
        let width = view.frame.width
        let frame = CGRect(x: 0, y: 0, width: width, height: 210)
        let cycleScrollView = SDCycleScrollView(frame: frame, delegate: self, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        
        cycleScrollView?.imageURLStringsGroup = [
        "http://tbfile.ixiaochuan.cn/img/view/id/144454924",
        "http://tbfile.ixiaochuan.cn/img/view/id/152253123",
        "http://tbfile.ixiaochuan.cn/img/view/id/136695663",
        "http://tbfile.ixiaochuan.cn/img/view/id/119808917",
        "http://tbfile.ixiaochuan.cn/img/view/id/103451768"
        ]
        cycleScrollView?.autoScrollTimeInterval = 3.0
        tableView.tableHeaderView = cycleScrollView
        tableView.rowHeight = 80
        //注册cell
        self.tableView.register(UINib.init(nibName: "TYTopicCell", bundle: nil), forCellReuseIdentifier: "KTYTopicCell")
       
    }
    override func loadNewData() {
      self.tableView.mj_header.endRefreshing()
      self.dataSource = [
            ["id":118719,"topic":"求大神P图","cover":95444072],
            ["id":101883,"topic":"八卦来了","cover":151512301],
            ["id":104785,"topic":"古风小院","cover":152261001],
            ["id":101666,"topic":"那个叫学校的地方","cover":13864278],
            ["id":100198,"topic":"汪了个喵","cover":31239125],
            ["id":101610,"topic":"二次元聚集地","cover":33315076],
            ["id":125921,"topic":"这个视频有毒","cover":13976240],
            ["id":161794,"topic":"王者荣耀搞笑时刻","cover":20325511],
            ["id":112357,"topic":"声控福利社","cover":22038816],
            ["id":126160,"topic":"这特么都是套路","cover":15223171],
            ["id":102219,"topic":"这是何等的卧槽","cover":19898116],
            ["id":103495,"topic":"神评论集中营","cover":13986775],
        ]
//     let path = TYServiceApi.service(forImagePath: api_topic_cover, imageID: 95444072, size: 420)
    }
    override func loadMoreData() {
       self.tableView.mj_footer.endRefreshing()
     
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = dataSource ?? []
       
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KTYTopicCell") as! TYTopicCell
        if  let dict = self.dataSource[indexPath.row] as? NSDictionary,
            let imageID = dict["cover"] as? UInt,
            let topic = dict["topic"] as? String,
            let imagePath = TYServiceApi.service(forImagePath: api_topic_cover, imageID: imageID, size: 420) {
            let url = URL.init(string: imagePath)
            cell.avatarView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "placeholder"))
            cell.titleLabel.text = topic
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let width = view.frame.width
        return TYTopicBanner(frame: CGRect(x: 0, y: 0, width: width, height: 40))
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

}
