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
    
    func populateCell(dayOfEating:DayOfEating?){
        caloriesLabel.text = "CAL: \(dayOfEating?.overallCalories ?? 0)"
        proteinLabel.text = "P: \(dayOfEating?.overallProtein ?? 0)"
        carbsLabel.text = "C: \(dayOfEating?.overallCarbs ?? 0)"
        fatsLabel.text = "F: \(dayOfEating?.overallFats ?? 0)"
    }
}
