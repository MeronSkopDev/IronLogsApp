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
    
    
    /**
    This method
    Inserts given exerciseName into exerciseName
    */
    func initCell(exerciseName:String){
        exerciseNameEditText.text = exerciseName
    }
    
    
    var delegateGetText:editTextObserversDelegate?
    
    /**
     This method
     Adds a target method to exerciseNameEditText
     The target method notices changes in the text
     */
    func initTextObserver(){
        exerciseNameEditText.addTarget(self, action: #selector(observeExerciseNameChange(_:)), for: .editingDidEnd)
    }
    
    func getExerciseName() -> String{
        if let text = exerciseNameEditText.text{
            return text
        }
        return " "
    }
    
    /**
     This method (@objc)
     Gives the text of exerciseNameEditText and sends it to delegateGetText
     */
    @objc func observeExerciseNameChange(_ titleLabel:UITextField){
        delegateGetText?.getTextOnChange(text: titleLabel.text ?? " ")
    }
}
