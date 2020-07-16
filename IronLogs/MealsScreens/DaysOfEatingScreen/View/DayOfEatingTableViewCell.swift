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
    
    
    @IBOutlet weak var backroundImage: UIImageView!
    
    var didSet = false
    
    /**
     This method
     Filles up all the Labels with the data from the "DayOfEating"
     Formattes the date gotten from the "DayOfEating" into a string to show the user
     */
    func populateCell(dayOfEating:DayOfEating){
        titleLabel.text = dayOfEating.title
        carbsLabel.text = "C: \(dayOfEating.calculatedOverallCarbs)"
        caloriesLabel.text = "CAL: \(dayOfEating.calculatedOverallCalories)"
        fatsLabel.text = "F: \(dayOfEating.calculatedOverallFats)"
        proteinLabel.text = "P\(dayOfEating.calculatedOverallProtein)"
        
        if dayOfEating.dateOfCreation != nil, let date = dayOfEating.dateOfCreation{
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            let formattedDate = formatter.string(from: date)
            dateOfCreationLabel.text = formattedDate
        }else{
            dateOfCreationLabel.text = "No date"
        }
        
        
    }
    
    func choosePic(lastImageNumChosen:Int) -> Int{
        if(!didSet){
            didSet = !didSet
            return  ImageLoading.choosePic(
                lastImageNumChosen: lastImageNumChosen,
                imageView: backroundImage,
                lastImageNum: 10,
                imageName: "mealPic")
        }
        return 1
    }
    
}
