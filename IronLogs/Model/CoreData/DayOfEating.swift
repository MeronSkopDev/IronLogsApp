//
//  DayOfEating.swift
//  IronLogs
//
//  Created by Meron Skop on 18/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

extension DayOfEating{
    convenience init(title:String,calories:Int16,carbs:Int16,fats:Int16,protein:Int16,dateOfCreation:Date) {
        self.init(context: CM.shared.context)
        
        self.overallCalories = calories
        self.overallCarbs = carbs
        self.dateOfCreation = dateOfCreation
        self.overallFats = fats
        self.overallProtein = protein
        self.title = title
    }
}
