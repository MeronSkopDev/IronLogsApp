//
//  MacrosTableViewCell.swift
//  IronLogs
//
//  Created by Meron Skop on 19/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

//MARK: tidy up this class and summerize the whole annimation thing you did with the circles

class MacrosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var carbsLabel: UILabel!
    
    @IBOutlet weak var fatsLabel: UILabel!
    
    
    @IBOutlet weak var proteinStack: UIStackView!
    
    @IBOutlet weak var carbsStack: UIStackView!
    
    @IBOutlet weak var fatsStack: UIStackView!
    
    var totalMacros:Int?
    var protein:Int16?
    var carbs:Int16?
    var fats:Int16?
    
    var timesRan = 0
    
    /**
     This method
     Filles up all the Labels with the data from the "DayOfEating"
     */
    func populateCell(dayOfEating:DayOfEating?){
        self.protein = dayOfEating?.calculatedOverallProtein ?? 0
        self.carbs = dayOfEating?.calculatedOverallCarbs ?? 0
        self.fats = dayOfEating?.calculatedOverallFats ?? 0
        caloriesLabel.text = "CAL: \(dayOfEating?.calculatedOverallCalories ?? 0)"
        proteinLabel.text = "\(protein ?? 0)"
        carbsLabel.text = "\(carbs ?? 0)"
        fatsLabel.text = "\(fats ?? 0)"
        
        self.totalMacros = dayOfEating?.calculateOverallMacros ?? 0
        
        while(timesRan < 1){
        drawProteinCircle()
        drawfatsCircle()
        drawCarbsCircle()
        timesRan = timesRan + 1
        }
    }
    
    override func awakeFromNib() {
        
    }
    
    func getPartInFraction(partToFind: Int16) -> Float{
        return Float(partToFind)/Float(totalMacros ?? 1)
    }
    
    func drawProteinCircle(){
        let lineLayer = CAShapeLayer()
        
        let centerX = proteinStack.center.x + 13
        let centerY = proteinStack.center.y + 10
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        lineLayer.fillColor = nil
        
        lineLayer.path = circlePath.cgPath
        lineLayer.strokeColor = UIColor.red.cgColor
        lineLayer.lineWidth = 5
        
        lineLayer.strokeEnd = 0
        
        lineLayer
            .add(getAnimationForCircle(partToFill:getPartInFraction(partToFind: protein ?? 1)), forKey: "protein")
        
        let trackLayer = CAShapeLayer()
        
        trackLayer.path = circlePath.cgPath
        
        trackLayer.fillColor = nil
        
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.lineCap = .round
        
        contentView.layer.addSublayer(trackLayer)
        
        contentView.layer.addSublayer(lineLayer)
    }
    
    func drawCarbsCircle(){
        let lineLayer = CAShapeLayer()
        
        let centerX = carbsStack.center.x + 17
        let centerY = carbsStack.center.y + 10
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        lineLayer.fillColor = nil
        
        lineLayer.path = circlePath.cgPath
        lineLayer.strokeColor = UIColor.blue.cgColor
        lineLayer.lineWidth = 5
        
        lineLayer.strokeEnd = 0
        
        lineLayer
            .add(getAnimationForCircle(partToFill: getPartInFraction(partToFind: carbs ?? 1)), forKey: "carbs")
        
        let trackLayer = CAShapeLayer()
        
        trackLayer.path = circlePath.cgPath
        
        trackLayer.fillColor = nil
        
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.lineCap = .round
        
        contentView.layer.addSublayer(trackLayer)
        
        contentView.layer.addSublayer(lineLayer)
    }
    
    func drawfatsCircle(){
        let lineLayer = CAShapeLayer()
        
        let centerX = fatsStack.center.x + 20
        let centerY = fatsStack.center.y + 10
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        lineLayer.fillColor = nil
        
        lineLayer.strokeEnd = 0
        
        lineLayer.path = circlePath.cgPath
        lineLayer.strokeColor = UIColor.systemYellow.cgColor
        lineLayer.lineWidth = 5
        
        lineLayer.lineCap = .round
        
        lineLayer
            .add(getAnimationForCircle(partToFill: getPartInFraction(partToFind: fats ?? 1)), forKey: "fats")
        
        let trackLayer = CAShapeLayer()
        
        trackLayer.path = circlePath.cgPath
        
        trackLayer.fillColor = nil
        
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.lineCap = .round
        
        contentView.layer.addSublayer(trackLayer)
        
        contentView.layer.addSublayer(lineLayer)
    }
    
    func getAnimationForCircle(partToFill:Float) -> CABasicAnimation{
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = partToFill
        
        basicAnimation.duration = 2
        
        //This will make sure that after the stroke is drawn it is not removed
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        return basicAnimation
    }
}
