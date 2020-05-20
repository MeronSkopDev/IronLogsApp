//
//  DayOfEatingTableViewModel.swift
//  IronLogs
//
//  Created by Meron Skop on 19/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

struct DayOfEatingTableViewModel {
    func createNewDayOfEating(){
        let _ = DayOfEating(title: "New day",
        calories: 0,
        carbs: 0,
        fats: 0,
        protein: 0,
        dateOfCreation: Date())
        CM.shared.saveContext()
    }
}
