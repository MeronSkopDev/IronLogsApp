//
//  SingleExerciseTableViewCell.swift
//  9.4.2020LoginAndSaveToRealTimeDatabase
//
//  Created by Meron Skop on 19/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class SingleExerciseTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    /**
    This method
    Inserts given exerciseName into exerciseNameLabel
    */
    func initCell(exerciseName:String){
        exerciseNameLabel.text = exerciseName
    }
    
}
