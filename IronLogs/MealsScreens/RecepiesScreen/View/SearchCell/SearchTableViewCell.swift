//
//  SearchTableViewCell.swift
//  IronLogs
//
//  Created by Meron Skop on 08/06/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var calorieTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    @IBOutlet weak var carbsTextField: UITextField!
    @IBOutlet weak var fatsTextField: UITextField!
    
    var queryDelegate:ApiFoodItemsQuerysDelegate?
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        var minCalories:Int
        var maxCalories:Int
        
        if calorieTextField.text != ""{
            minCalories = Int(calorieTextField.text!) ?? 0
            maxCalories = minCalories + 50
        }else{
            minCalories = 0
            maxCalories = 1000
        }
        
        var minProtein:Int
        var maxProtein:Int
        
        if proteinTextField.text != ""{
            minProtein = Int(proteinTextField.text!) ?? 0
            maxProtein = minProtein + 5
        }else{
            minProtein = 0
            maxProtein = 100
        }
        
        var minFat:Int
        var maxFat:Int
        
        if fatsTextField.text != ""{
            minFat = Int(fatsTextField.text!) ?? 0
            maxFat = minFat + 5
        }else{
            minFat = 0
            maxFat = 100
        }
        
        var minCarbs:Int
        var maxCarbs:Int
        
        if carbsTextField.text != ""{
            minCarbs = Int(carbsTextField.text!) ?? 0
            maxCarbs = minCarbs + 5
        }else{
            minCarbs = 0
            maxCarbs = 100
        }
        
        
        queryDelegate?.getFoodItems(querys: [
            "minCalories":"\(minCalories)",
            "maxCalories":"\(maxCalories)",
            "minProtein":"\(minProtein)",
            "maxProtein":"\(maxProtein)",
            "minCarbs":"\(minCarbs)",
            "maxCarbs":"\(maxCarbs)",
            "minFat":"\(minFat)" ,
            "maxFat":"\(maxFat)"
        ])
    }
    
}
