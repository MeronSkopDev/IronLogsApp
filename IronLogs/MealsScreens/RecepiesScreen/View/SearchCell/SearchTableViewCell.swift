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
    
    @IBOutlet weak var searchButton: UIButton!
    
    var queryDelegate:ApiFoodItemsQuerysDelegate?
    
    func initCellUI(){
        styleButton()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        var minCalories:Int
        var maxCalories:Int
        
        (minCalories, maxCalories) = getMinMaxMacros(
            textFieldToCheck: calorieTextField,
            maxDefault: 1000,
            minDefault: 0, diff: 50)
        
        var minProtein:Int
        var maxProtein:Int
        
        (minProtein, maxProtein) = getMinMaxMacros(
            textFieldToCheck: proteinTextField,
            maxDefault: 100,
            minDefault: 0, diff: 5)
        
        
        var minFat:Int
        var maxFat:Int
        
        (minFat, maxFat) = getMinMaxMacros(
            textFieldToCheck: fatsTextField,
            maxDefault: 100,
            minDefault: 0, diff: 5)
        
        
        var minCarbs:Int
        var maxCarbs:Int
        
        (minCarbs, maxCarbs) = getMinMaxMacros(
            textFieldToCheck: carbsTextField,
            maxDefault: 100,
            minDefault: 0, diff: 5)
        
        let cacheString = "\(minCalories)\(maxCalories)\(minCarbs)\(maxCarbs)\(minProtein)\(maxProtein)\(minFat)\(maxFat)"
        
        queryDelegate?.getFoodItems(querys: [
            "minCalories":"\(minCalories)",
            "maxCalories":"\(maxCalories)",
            "minProtein":"\(minProtein)",
            "maxProtein":"\(maxProtein)",
            "minCarbs":"\(minCarbs)",
            "maxCarbs":"\(maxCarbs)",
            "minFat":"\(minFat)" ,
            "maxFat":"\(maxFat)"
            ],
            cacheString:cacheString)
    }
    
    func getMinMaxMacros(textFieldToCheck:UITextField, maxDefault:Int, minDefault:Int, diff:Int) -> (Int,Int){
        var minMacros = 0
        var maxMacros = 0
        
        if textFieldToCheck.text != ""{
            minMacros = Int(textFieldToCheck.text!) ?? 0
            maxMacros = minMacros + diff
        }else{
            minMacros = minDefault
            maxMacros = maxDefault
        }
        return (minMacros,maxMacros)
    }
    
    func styleButton(){
        searchButton.layer.cornerRadius = 15.0
        searchButton.clipsToBounds = true
        searchButton.setTitleColor(UIColor.lightGray, for: .selected)
    }
}
