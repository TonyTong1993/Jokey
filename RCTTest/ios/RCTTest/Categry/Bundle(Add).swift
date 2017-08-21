//
//  Bundle(Add).swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/15.
//  Copyright © 2017年 童万华. All rights reserved.
//

import Foundation

extension Bundle {
    func loadJsonDataFromBundle(fileName:String) -> AnyObject? {
       let fileURL = self.url(forResource: fileName, withExtension: "json")
        guard let url = fileURL,
              let data = try? Data(contentsOf: url, options: .dataReadingMapped),
              let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject else {
            return nil
        }
                return json
        
    }
}
