//
//  FoodItem.swift
//  IronLogs
//
//  Created by Meron Skop on 18/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

extension FoodItem{
    
    /**
     This init
     A conviniance init made to have a simple and easy way to create a new "FoodItem"
     */
    convenience init(timeEaten:Date,calories:Int16,carbs:Int16,fats:Int16,protein:Int16,name:String){
        self.init(context: CM.shared.context)
        
        self.calories = calories
        self.carbs = carbs
        self.timeEaten = timeEaten
        self.fats = fats
        self.protein = protein
        self.name = name
    }
    
    var calculatedOverallCalories:Int16{
        var calories:Int16 = 0
        
        let carbsCal = carbs * 4
        
        let fatsCal = fats * 9
        
        let proteinCal = protein * 4
        
        calories = fatsCal + carbsCal + proteinCal
        
        return calories
    }
}
