//
//  ExerciseNameTableViewCell.swift
//  9.4.2020LoginAndSaveToRealTimeDatabase
//
//  Created by Meron Skop on 19/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class ExerciseNameTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var exerciseNameEditText: UITextField!
    
    var currentExercise:Workout.Exercise?
    
    /**
    This method
    Inserts given exerciseName into exerciseName
    */
    func initCell(currentExercise:Workout.Exercise){
        exerciseNameEditText.text = currentExercise.exerciseName
        self.currentExercise = currentExercise
    }
    
    /**
     This method
     Adds a target method to exerciseNameEditText
     The target method notices changes in the text
     */
    func initTextObserver(){
        exerciseNameEditText.addTarget(self, action: #selector(observeExerciseNameChange(_:)), for: .editingChanged)
    }
    
    /**
     This method (@objc)
     Gives the text of exerciseNameEditText and sends it to delegateGetText
     */
    @objc func observeExerciseNameChange(_ titleLabel:UITextField){
        currentExercise?.exerciseName = titleLabel.text ?? " "
    }
}
