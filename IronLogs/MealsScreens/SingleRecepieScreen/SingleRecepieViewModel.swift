//
//  SingleRecepieViewModel.swift
//  IronLogs
//
//  Created by Meron Skop on 14/06/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

struct SingleRecepieViewModel{
    
    func addMeal(mealToAdd:APIFoodItem, currentDayOfEating:DayOfEating){
        let calories:Int16 = Int16(mealToAdd.calories)
        let fats:Int16 = stringToNut(toConv: mealToAdd.fat)
        let carbs:Int16 = stringToNut(toConv: mealToAdd.carbs)
        let protein:Int16 = stringToNut(toConv: mealToAdd.protein)
        
        currentDayOfEating.addToFoodItem(FoodItem(
            timeEaten: Date(),
            calories: calories,
            carbs: carbs,
            fats: fats,
            protein: protein,
            name: mealToAdd.title))
        
        CM.shared.saveContext()
        
    }
    
    func stringToNut(toConv:String) -> Int16{
        
        let clean = toConv.prefix(toConv.count - 1)
        return Int16(clean) ?? 0
    }
    
    func addLabel(content:String, stack:UIStackView, view:UIView){
        let proLabel = UILabel()
        proLabel.text = content
        proLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        proLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(proLabel)
        stack.addArrangedSubview(proLabel)
    }
    
}
