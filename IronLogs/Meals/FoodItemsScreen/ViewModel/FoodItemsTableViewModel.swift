//
//  FoodItemsTableViewModel.swift
//  IronLogs
//
//  Created by Meron Skop on 23/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation


struct FoodItemsTableViewModel{
    /**
     This method
     Creates a new "FoodItem"
     Adds that new "FoodItem" to the "DayOfEating" given
     Saves context
     */
    func addNewFoodItem(dayOfEating:DayOfEating?){
        dayOfEating?.addToFoodItem(FoodItem(timeEaten: Date(),
                                                   calories: 0,
                                                   carbs: 0,
                                                   fats: 0,
                                                   protein: 0,
                                                   name: "New FoodItem"))
        CM.shared.saveContext()
    }
}
