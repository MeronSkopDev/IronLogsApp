//
//  RecepieTableViewCell.swift
//  IronLogs
//
//  Created by Meron Skop on 25/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class RecepieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var carbsLabel: UILabel!
    
    @IBOutlet weak var fatsLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func populateCell(recepie:APIFoodItem){
        
        proteinLabel.text = recepie.protein
        nameLabel.text = recepie.title
        caloriesLabel.text = "\(recepie.calories)"
        carbsLabel.text = recepie.carbs
        fatsLabel.text = recepie.fat
    }
    
}
