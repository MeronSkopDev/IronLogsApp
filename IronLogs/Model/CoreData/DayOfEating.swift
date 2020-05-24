//
//  DayOfEating.swift
//  IronLogs
//
//  Created by Meron Skop on 18/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

extension DayOfEating{
    
    /**
    This init
    A conviniance init made to have a simple and easy way to create a new "DayOfEating"
    */
    convenience init(title:String,calories:Int16,carbs:Int16,fats:Int16,protein:Int16,dateOfCreation:Date) {
        self.init(context: CM.shared.context)
        
        self.overallCalories = calories
        self.overallCarbs = carbs
        self.dateOfCreation = dateOfCreation
        self.overallFats = fats
        self.overallProtein = protein
        self.title = title
    }
    
    /**
     This computed value
     Keeps track of all the "FoodItem" inside of the "DayOfEating" in an array format
     */
    public var foodItemsInside:Box<[FoodItem]>{
        
        let foodItems = foodItem?.allObjects as? [FoodItem] ?? []
        let foodItemsBoxed = Box([FoodItem]())
        foodItemsBoxed.value = foodItems
        
        return foodItemsBoxed
    }
    
    /**
     This method
     Keeps track of the sum of all the "calories" of all the "FoodItem" inside the "DayOfEating"
     */
    var calculatedOverallCalories:Int16{
        var calories:Int16 = 0
        for i in foodItemsInside.value{
            calories = calories + i.calories
        }
        overallCalories = calories
        return calories
    }
    /**
    This method
    Keeps track of the sum of all the "protein" of all the "FoodItem" inside the "DayOfEating"
    */
    var calculatedOverallProtein:Int16{
        var protein:Int16 = 0
        for i in foodItemsInside.value{
            protein = protein + i.protein
        }
        overallProtein = protein
        return protein
    }
    /**
    This method
    Keeps track of the sum of all the "carbs" of all the "FoodItem" inside the "DayOfEating"
    */
    var calculatedOverallCarbs:Int16{
        var carbs:Int16 = 0
        for i in foodItemsInside.value{
            carbs = carbs + i.carbs
        }
        overallCarbs = carbs
        return carbs
    }
    /**
    This method
    Keeps track of the sum of all the "fats" of all the "FoodItem" inside the "DayOfEating"
    */
    var calculatedOverallFats:Int16{
        var fats:Int16 = 0
        for i in foodItemsInside.value{
            fats = fats + i.fats
        }
        overallFats = fats
        return fats
    }
}
