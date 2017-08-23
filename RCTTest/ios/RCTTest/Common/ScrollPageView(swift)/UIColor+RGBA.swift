//
//  UIColor+RGBA.swift
//  RCTTest
//
//  Created by 童万华 on 2017/8/22.
//  Copyright © 2017年 童万华. All rights reserved.
//

import Foundation
extension UIColor {
    //返回标准的RGBA色值数组
    func rgba() -> [CGFloat]? {
        guard let components = self.cgColor.components else {
            return nil
        }
        
        if components.count == 2 {
            if self == UIColor.clear {
                return [0.0,0.0,0.0,0.0]
            }else if self == UIColor.black {
                return [0.0,0.0,0.0,1.0]
            }else if self == UIColor.white {
                return [1.0,1.0,1.0,1.0]
            }else if self == UIColor.gray {
                return [0.5,0.5,0.5,1.0]
            }else if self == UIColor.darkGray {
                return [0.333,0.333,0.333,1.0]
            }else if self == UIColor.lightGray {
                return [0.667,0.667,0.667,1.0]
            }
        }
        return components
    }
    
   class func gradientRGBA(normalRgbaComponents:[CGFloat]?,selectedRgbaComponents:[CGFloat]?) -> [CGFloat]? {
        guard let normalRgbaComponents = normalRgbaComponents,
            let selectedRgbaComponents = selectedRgbaComponents  else {
                return nil
        }
        let deltaR = normalRgbaComponents[0] - selectedRgbaComponents[0]
        let deltaG = normalRgbaComponents[1] - selectedRgbaComponents[1]
        let deltaB = normalRgbaComponents[2] - selectedRgbaComponents[2]
        let deltaA = normalRgbaComponents[3] - selectedRgbaComponents[3]
        return [deltaR,deltaG,deltaB,deltaA]
    }
    
   class func transfromToNormalColor(selectedRgbaComponents:[CGFloat]?,deltaRGBA:[CGFloat]?,scale:CGFloat) -> UIColor? {
        guard let selectedRgbaComponents = selectedRgbaComponents,
            let deltaRGBA = deltaRGBA else {
                return nil
        }
        let normalR = selectedRgbaComponents[0] + deltaRGBA[0]*scale
        let normalG = selectedRgbaComponents[1] + deltaRGBA[1]*scale
        let normalB = selectedRgbaComponents[2] + deltaRGBA[2]*scale
        let normalA = selectedRgbaComponents[3] + deltaRGBA[3]*scale
        
        return UIColor(red: normalR, green: normalG, blue: normalB, alpha: normalA)
    }
   class func transfromToSelectedColor(normalRgbaComponents:[CGFloat]?,deltaRGBA:[CGFloat]?,scale:CGFloat) -> UIColor? {
        guard let normalRgbaComponents = normalRgbaComponents,
            let deltaRGBA = deltaRGBA else {
                return nil
        }
        let selectedR = normalRgbaComponents[0] - deltaRGBA[0]*scale
        let selectedG = normalRgbaComponents[1] - deltaRGBA[1]*scale
        let selectedB = normalRgbaComponents[2] - deltaRGBA[2]*scale
        let selectedA = normalRgbaComponents[3] - deltaRGBA[3]*scale
        
        return UIColor(red: selectedR, green: selectedG, blue: selectedB, alpha: selectedA)
    }
}
