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
    
    var fatsCircle:CAShapeLayer?
    var proteinCircle:CAShapeLayer?
    var carbsCircle:CAShapeLayer?
    
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
            drawMacrosCircle()
            timesRan = timesRan + 1
        }
        
        bindDayOfEating(toBind: Box(dayOfEating ?? DayOfEating()))
        
    }
    
    func bindDayOfEating(toBind:Box<DayOfEating>){
        toBind.bind { (new) in
            guard let proteinCircle = self.proteinCircle, let carbsCircle = self.carbsCircle, let fatsCircle = self.fatsCircle else {
                return
            }
            
            proteinCircle.add(DrawCircle.getAnimationForCircle(
                partToFill: DrawCircle.getPartInFraction(
                    partToFind: self.protein ?? 1,
                    total: self.totalMacros ?? 1)), forKey: "macrosCircles")
            
            carbsCircle.add(DrawCircle.getAnimationForCircle(
                partToFill: DrawCircle.getPartInFraction(
                    partToFind: self.carbs ?? 1,
                    total: self.totalMacros ?? 1)), forKey: "macrosCircles")
            
            fatsCircle.add(DrawCircle.getAnimationForCircle(
                partToFill: DrawCircle.getPartInFraction(
                    partToFind: self.fats ?? 1,
                    total: self.totalMacros ?? 1)), forKey: "macrosCircles")
        }
    }
    
    func drawMacrosCircle(){
        ///Protein circle
        proteinCircle = DrawCircle.drawCircleForMacros(fillAmount: DrawCircle.getPartInFraction(partToFind: protein ?? 1, total: totalMacros ?? 1),
                                                       color: UIColor.red.cgColor,
                                                       centerX: proteinStack.center.x + 13,
                                                       centerY: proteinStack.center.y + 10,
                                                       drawOn: contentView.layer)
        
        ///Carbs circle
        carbsCircle = DrawCircle.drawCircleForMacros(fillAmount: DrawCircle.getPartInFraction(partToFind: carbs ?? 1, total: totalMacros ?? 1),
                                                     color: UIColor.systemBlue.cgColor,
                                                     centerX: carbsStack.center.x + 17,
                                                     centerY: carbsStack.center.y + 10,
                                                     drawOn: contentView.layer)
        ///Fats circle
        fatsCircle = DrawCircle.drawCircleForMacros(fillAmount: DrawCircle.getPartInFraction(partToFind: fats ?? 1, total: totalMacros ?? 1),
                                                    color: UIColor.systemYellow.cgColor,
                                                    centerX: fatsStack.center.x + 20,
                                                    centerY: fatsStack.center.y + 10,
                                                    drawOn: contentView.layer)
    }
    
}
