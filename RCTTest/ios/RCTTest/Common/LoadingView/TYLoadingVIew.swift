//
//  TYLoadingVIew.swift
//  RCTTest
//
//  Created by 童万华 on 2017/10/26.
//  Copyright © 2017年 童万华. All rights reserved.
//

import UIKit

class TYLoadingVIew: UIView {
    var lineWidth:CGFloat = 0
    var lineLength:CGFloat = 0
    var margin:CGFloat = 0
    var duration:Double = 2
    var interval:Double = 1
    var colors:[UIColor] = [UIColor.hex(0x9DD4E9) ,UIColor.hex(0xF5BD58), UIColor.hex(0xFF317E) ,UIColor.hex(0x6FC9B5)]
    //动画的状态
    private(set) var status:AnimationStatus = .Normal
    //四条线
    private var lines:[CAShapeLayer] = []
    enum AnimationStatus {
        //普通状态
        case Normal
        //动画中
        case Animating
        //暂停
        case pause
    }
    
    //MARK: Initial Methods
    convenience init(frame: CGRect , colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = colors
        config()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    private func config() {
        lineLength = max(frame.width, frame.height)
        lineWidth = lineLength/6.0
        margin   = lineLength/4.5 + lineWidth/2
        drawLineShapeLayer()
        transform = CGAffineTransform.init(rotationAngle: -30)
    }
    
    //MARK: 绘制线
    /**
     绘制四条线
     */
    private func drawLineShapeLayer() {
        //开始点
        let startPoint = [point(x:lineWidth/2, y: margin),
                          point(x:lineLength - margin, y: lineWidth/2),
                          point(x:lineLength - lineWidth/2, y: lineLength - margin),
                          point(x:margin, y: lineLength - lineWidth/2)]
        //结束点
        let endPoint  = [point(x:lineLength - lineWidth/2, y: margin) ,
                         point(x:lineLength - margin, y: lineLength - lineWidth/2) ,
                         point(x:lineWidth/2, y: lineLength - margin) ,
                         point(x:margin, y: lineWidth/2)]
        for i in 0...3 {
            let line:CAShapeLayer = CAShapeLayer()
            line.lineWidth  = lineWidth
            line.lineCap   = kCALineCapRound
            line.opacity   = 0.8
            line.strokeColor = colors[i].cgColor
            line.path    = getLinePath(startPoint: startPoint[i], endPoint: endPoint[i]).cgPath
            layer.addSublayer(line)
            lines.append(line)
        }
        
    }
    /**
     获取线的路径
     
     - parameter startPoint: 开始点
     - parameter endPoint:  结束点
     
     - returns: 线的路径
     */
    private func getLinePath(startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to:startPoint)
        path.addLine(to:endPoint)
        return path
    }
    
    private func point(x:CGFloat , y:CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    private func angle(angle: Double) -> CGFloat {
        return CGFloat(angle * (Double.pi/180))
    }
    
    //MARK: 动画步骤
    /**
     旋转的动画，旋转两圈
     */
    private func angleAnimation() {
        let angleAnimation         = CABasicAnimation.init(keyPath: "transform.rotation.z")
        angleAnimation.fromValue      = angle(angle:-30)
        angleAnimation.toValue       = angle(angle:690)
        angleAnimation.fillMode      = kCAFillModeForwards
        angleAnimation.isRemovedOnCompletion = false
        angleAnimation.duration      = duration
        angleAnimation.delegate      = self as? CAAnimationDelegate
        layer.add(angleAnimation, forKey: "angleAnimation")
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        angleAnimation()
    }

}
