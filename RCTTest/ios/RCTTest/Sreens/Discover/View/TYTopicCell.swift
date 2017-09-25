//
//  TYTopicCell.swift
//  RCTTest
//
//  Created by 童万华 on 2017/9/25.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYTopicCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var attention: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func attentionClicked(_ sender: UIButton) {
        
    }
    
}
