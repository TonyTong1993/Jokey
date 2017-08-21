//
//  TYAttentionViewController.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/14.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYAttentionViewController: TYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       loadNewData()
     
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        let height = tableView.mj_h - 49
        tableView.mj_h = height;
        //注册cell
        tableView.register(TYAttentionViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
       
        
        
        //style
        tableView.separatorColor = UIColor(hex:NSInteger(separatorColorHexValue))
        tableView.mj_header.removeFromSuperview()
        tableView.mj_footer.removeFromSuperview()
    }
    
    
   

}
extension TYAttentionViewController {
    override func loadNewData() {
        if let json =  Bundle.main.loadJsonDataFromBundle(fileName: "topic") {
            let data = (json as! [String:Any])["data"] as! [String:Any]
            let list = data["list"] as! [[String:Any]]
            
            for item in list {
                let topic = item["topic"] as! String
                let coverID = item["cover"] as! Int
                let newCnt = item["newcnt"] as! Int
                let attention =  TYAttention(topic: topic, coverID: coverID,newcnt:newCnt)
                dataSource.append(attention);
                
            }
        }
        tableView.reloadData()
    
    }
    
}
extension TYAttentionViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = dataSource {
            return dataSource.count
        }
        return 0
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
}
