//
//  FoodItemTableViewCell.swift
//  IronLogs
//
//  Created by Meron Skop on 22/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    @IBOutlet weak var carbsTextField: UITextField!
    @IBOutlet weak var fatsTextField: UITextField!
    @IBOutlet weak var timeEatenLabel: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    
    @IBOutlet weak var backroundImage: UIImageView!
    var didSet = false
    
    var foodItem:FoodItem?
    
    /**
     This method
     Filles up all the TextFields with the data from the "FoodItem"
     Formattes the date gotten from the "FoodItem" into a string to show the user
     */
    func populateCell(foodItem:FoodItem){
        self.foodItem = foodItem
        
        nameTextField.text = foodItem.name
        caloriesLabel.text = "CAL: \(foodItem.calculatedOverallCalories)"
        proteinTextField.text = "P: \(foodItem.protein)"
        carbsTextField.text = "C: \(foodItem.carbs)"
        fatsTextField.text = "F: \(foodItem.fats)"
        
        if foodItem.timeEaten != nil{
            let reltiveFormatter = RelativeDateTimeFormatter()
            reltiveFormatter.dateTimeStyle = .named
            let timeEaten = reltiveFormatter.string(for: foodItem.timeEaten!)
            timeEatenLabel.text = timeEaten
        }else{
            timeEatenLabel.text = "No time given"
        }
    }
    
    /**
     This method
     Adds two sets of targets to the TextFields
     set 1) Methods that know when the TextFields are edited
     set 2) Methods that know when the TextFields are not edited any more
     */
    func initObservers(){
        nameTextField.addTarget(self, action: #selector(changeFoodItemName(_:)), for: .editingChanged)
        proteinTextField.addTarget(self, action: #selector(changeFoodItemProtein(_:)), for: .editingChanged)
        carbsTextField.addTarget(self, action: #selector(changeFoodItemCarbs(_:)), for: .editingChanged)
        fatsTextField.addTarget(self, action: #selector(changeFoodItemFats(_:)), for: .editingChanged)
        
        proteinTextField.addTarget(self, action: #selector(updateFoodItemProteinTextField(_:)), for: .editingDidEnd)
        carbsTextField.addTarget(self, action: #selector(updateFoodItemCarbsTextField(_:)), for: .editingDidEnd)
        fatsTextField.addTarget(self, action: #selector(updateFoodItemFatsTextField(_:)), for: .editingDidEnd)
    }
    
    /**
     This method
     Saves the name the user inputed in the "FoodItem"
     */
    @objc func changeFoodItemName(_ sender:UITextField){
        foodItem?.name = sender.text
        CM.shared.saveContext()
    }
    
    /**
     This method
     Saves the protein the user inputed in the "FoodItem"
     */
    @objc func changeFoodItemProtein(_ sender:UITextField){
        if let protein = sender.text{
            foodItem?.protein = Int16(protein) ?? 0
            CM.shared.saveContext()
        }
    }
    /**
     This method
     Saves the carbs the user inputed in the "FoodItem"
     */
    @objc func changeFoodItemCarbs(_ sender:UITextField){
        if let carbs = sender.text{
            foodItem?.carbs = Int16(carbs) ?? 0
            CM.shared.saveContext()
        }
    }
    /**
     This method
     Saves the name the fats inputed in the "FoodItem"
     */
    @objc func changeFoodItemFats(_ sender:UITextField){
        if let fats = sender.text{
            foodItem?.fats = Int16(fats) ?? 0
            CM.shared.saveContext()
        }
    }
    
    @objc func updateFoodItemProteinTextField(_ sender:UITextField){
        proteinTextField.text = "P: \(foodItem?.protein ?? 0)"
        caloriesLabel.text = "CAL: \(foodItem?.calculatedOverallCalories ?? 0)"
    }
    @objc func updateFoodItemCarbsTextField(_ sender:UITextField){
        carbsTextField.text = "C: \(foodItem?.carbs ?? 0)"
        caloriesLabel.text = "CAL: \(foodItem?.calculatedOverallCalories ?? 0)"
    }
    @objc func updateFoodItemFatsTextField(_ sender:UITextField){
        fatsTextField.text = "F: \(foodItem?.fats ?? 0)"
        caloriesLabel.text = "CAL: \(foodItem?.calculatedOverallCalories ?? 0)"
    }
    
    func choosePic(lastImageNumChosen:Int) -> Int{
        
        if(!didSet){
            var imageNum = Int.random(in: 1...10)
            while(imageNum == lastImageNumChosen){
                imageNum = Int.random(in: 1...10)
            }
            backroundImage.image = UIImage(named: "mealPic\(imageNum)")
            backroundImage.layer.cornerRadius = 20.0
            backroundImage.clipsToBounds = true
            didSet = true
            return imageNum
        }
        return 1
    }
    
}
