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
        ["id":118719,"topic":"求大神P图","cover":95444072,"addition":"429801个P图大神"],
            ["id":101883,"topic":"八卦来了","cover":151512301,"addition":"242166个吃瓜群众"],
            ["id":104785,"topic":"古风小院","cover":152261001,"addition":"283295个古庭友"],
            ["id":101666,"topic":"那个叫学校的地方","cover":13864278,"addition":"418926个同学"],
            ["id":100198,"topic":"汪了个喵","cover":31239125,"addition":"2228068个汪汪喵喵"],
            ["id":101610,"topic":"二次元聚集地","cover":33315076,"addition":"190336个二次元"],
            ["id":125921,"topic":"这个视频有毒","cover":13976240,"addition":"1982634个情人"],
            ["id":161794,"topic":"王者荣耀搞笑时刻","cover":20325511,"addition":"198954个王者小坑货"],
            ["id":112357,"topic":"声控福利社","cover":22038816,"addition":"2042877个声控小伙伴"],
            ["id":126160,"topic":"这特么都是套路","cover":15223171,"addition":"1049417个套路君"],
            ["id":102219,"topic":"这是何等的卧槽","cover":19898116,"addition":"395319个卧槽马"],
            ["id":103495,"topic":"神评论集中营","cover":13986775,"addition":"671410个神评手"],
        ]

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
        cell.selectionStyle = .none
        if  let dict = self.dataSource[indexPath.row] as? NSDictionary,
            let imageID = dict["cover"] as? UInt,
            let topic = dict["topic"] as? String,
            let addition = dict["addition"] as? String,
            let imagePath = TYServiceApi.service(forImagePath: api_topic_cover, imageID: imageID, size: 420) {
            let url = URL.init(string: imagePath)
            cell.avatarView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "placeholder"))
            cell.titleLabel.text = topic
            cell.detailLabel.text = addition
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
