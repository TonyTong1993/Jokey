//
//  TYCategaryViewController.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/21.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYCategaryViewController: TYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        loadNewData()
        // Do any additional setup after loading the view.
    }
    override func setUpTableView() {
        super.setUpTableView()
        //注册cell
        tableView.register(TYAttentionViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        //style
        tableView.separatorColor = UIColor(hex:NSInteger(separatorColorHexValue))
        var bottomOffest:CGFloat = 0.0
        if #available(iOS 11, *) {
            bottomOffest = (UIScreen.main.bounds.size.width == 375.0 && UIScreen.main.bounds.size.height == 812.0) ?(88.0 + 83.0):(64.0 + 49.0)
        } else {
            bottomOffest = 64.0 + 49.0
        }
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomOffest, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset;
      
    }
    
}
extension TYCategaryViewController {
    override func loadNewData() {
        if let json =  Bundle.main.loadJsonDataFromBundle(fileName: "topic") {
            let data = (json as! [String:Any])["data"] as! [String:Any]
            let list = data["list"] as! [[String:Any]]
            
            for item in list {
                guard let topic = item["topic"] as? String,
                    let coverID = item["cover"] as? Int,
                    let newCnt = item["newcnt"] as? Int else {
                        return
                }
                
                let attention =  TYAttention(topic: topic, coverID: coverID,newcnt:newCnt)
                dataSource.append(attention);
                
            }
        }
        tableView.reloadData()
        
    }
    
}
extension TYCategaryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = dataSource ?? []
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let attention = self.dataSource[indexPath.row] as! TYAttention
        let attentionCell = cell as! TYAttentionViewCell
        let avatarURL = TYServiceApi.service(forImagePath: api_topic_cover, imageID: UInt(attention.coverID), size: 420 )
        let url = URL(string: avatarURL!);
        attentionCell.iconView.sd_setImage(with:url, placeholderImage: UIImage(named: "header_placeholder"))
        attentionCell.titlelabel.text = attention.topic
        attentionCell.rightLabel.text = "\(attention.newCnt)+条更新"
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let testVC = TYTestViewController()
        testVC.view.backgroundColor = UIColor.green
        navigationController?.pushViewController(testVC, animated: true)


    }
}
