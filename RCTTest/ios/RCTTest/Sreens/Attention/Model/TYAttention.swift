//
//  TYAttention.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/18.
//  Copyright © 2017年 童万华. All rights reserved.
//

import Foundation
struct TYAttention {
    var topic = ""
    var coverID = 0
    var newCnt = 0
    var newcnt: Int {
        get {
            return newCnt
        }
        set {
            
            newCnt = newValue>99 ?99:newValue
        }
    }
    init(topic:String,coverID:Int,newcnt:Int) {
        self.topic = topic
        self.coverID = coverID
        self.newcnt = newcnt
    }
    
    
}
