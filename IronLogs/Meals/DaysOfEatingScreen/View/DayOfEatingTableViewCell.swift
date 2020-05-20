//
//  DayOfEatingTableViewCell.swift
//  IronLogs
//
//  Created by Meron Skop on 18/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class DayOfEatingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateOfCreationLabel: UILabel!
    
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var fatsLabel: UILabel!
    
    @IBOutlet weak var carbsLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func populateCell(dayOfEating:DayOfEating){
        titleLabel.text = dayOfEating.title
        carbsLabel.text = "C: \(dayOfEating.overallCarbs)"
        caloriesLabel.text = "CAL: \(dayOfEating.overallCarbs)"
        fatsLabel.text = "F: \(dayOfEating.overallFats)"
        proteinLabel.text = "P\(dayOfEating.overallProtein)"
        
        if dayOfEating.dateOfCreation != nil, let date = dayOfEating.dateOfCreation{
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            let formattedDate = formatter.string(from: date)
            dateOfCreationLabel.text = formattedDate
        }else{
            dateOfCreationLabel.text = "No date"
        }
        
    }
    
}
