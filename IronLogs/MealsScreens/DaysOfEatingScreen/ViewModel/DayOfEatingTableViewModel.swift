//
//  DayOfEatingTableViewModel.swift
//  IronLogs
//
//  Created by Meron Skop on 19/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

struct DayOfEatingTableViewModel {
    /**
     This method
     Adds a new "DayOfEating' to the database
     */
    func createNewDayOfEating(currentUserUUID:String){
        let _ = DayOfEating(title: "New day",
        calories: 0,
        carbs: 0,
        fats: 0,
        protein: 0,
        dateOfCreation: Date(),
        uuid: currentUserUUID)
        CM.shared.saveContext()
    }
}
