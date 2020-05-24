//
//  MacrosTableViewCell.swift
//  IronLogs
//
//  Created by Meron Skop on 19/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class MacrosTableViewCell: UITableViewCell {

    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var carbsLabel: UILabel!
    
    @IBOutlet weak var fatsLabel: UILabel!
    
    /**
    This method
    Filles up all the Labels with the data from the "DayOfEating"
    */
    func populateCell(dayOfEating:DayOfEating?){
        caloriesLabel.text = "CAL: \(dayOfEating?.calculatedOverallCalories ?? 0)"
        proteinLabel.text = "P: \(dayOfEating?.calculatedOverallProtein ?? 0)"
        carbsLabel.text = "C: \(dayOfEating?.calculatedOverallCarbs ?? 0)"
        fatsLabel.text = "F: \(dayOfEating?.calculatedOverallFats ?? 0)"
    }
}
