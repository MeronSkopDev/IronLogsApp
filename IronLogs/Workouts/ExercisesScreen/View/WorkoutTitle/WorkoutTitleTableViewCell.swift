//
//  WorkoutTitleTableViewCell.swift
//  9.4.2020LoginAndSaveToRealTimeDatabase
//
//  Created by Meron Skop on 19/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class WorkoutTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var workoutTitleEditText: UITextField!
    
    var delegateGetText:editTextObserversDelegate?
    
    /**
    This method
    Inserts given workoutTitle into workoutTitleEditText
    */
    func initCell(workoutTitle:String){
        workoutTitleEditText.text = workoutTitle
    }
    
    /**
    This method
    Adds a target method to workoutTitleEditText
    The target method notices changes in the text
    */
    func initTextObserver(){
        workoutTitleEditText.addTarget(self, action: #selector(observeTitleChange(_:)), for: .editingDidEnd)
    }
    
    func getWorkoutTitle() -> String{
        if let text = workoutTitleEditText.text{
            return text
        }
        return " "
    }
    
    /**
    This method (@objc)
    Gives the text of exerciseNameEditText and sends it to delegateGetText
    */
    @objc func observeTitleChange(_ titleLabel:UITextField){
        delegateGetText?.getTextOnChange(text: titleLabel.text ?? " ")
    }
    
}


