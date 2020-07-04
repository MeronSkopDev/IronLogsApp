//
//  DrawCircle.swift
//  IronLogs
//
//  Created by Meron Skop on 30/06/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit


struct DrawCircle{
    
    static func getPartInFraction(partToFind: Int16, total:Int) -> Float{
        return Float(partToFind)/Float(total)
    }
    
    static func drawCircleForMacros(fillAmount: Float, color: CGColor ,centerX:CGFloat, centerY: CGFloat, drawOn: CALayer) -> CAShapeLayer{
        let lineLayer = CAShapeLayer()
        
        let centerX = centerX
        let centerY = centerY
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        lineLayer.fillColor = nil
        
        lineLayer.path = circlePath.cgPath
        lineLayer.strokeColor = color
        lineLayer.lineWidth = 5
        
        lineLayer.strokeEnd = 0
        
        lineLayer.add(getAnimationForCircle(partToFill: fillAmount), forKey: "macrosCircles")
        
        let trackLayer = CAShapeLayer()
        
        trackLayer.path = circlePath.cgPath
        
        trackLayer.fillColor = nil
        
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.lineCap = .round
        
        drawOn.addSublayer(trackLayer)
        
        drawOn.addSublayer(lineLayer)
        
        return lineLayer
    }
    
    
    static func getAnimationForCircle(partToFill:Float) -> CABasicAnimation{
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = partToFill
        
        basicAnimation.duration = 2
        
        //This will make sure that after the stroke is drawn it is not removed
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        return basicAnimation
    }
}
