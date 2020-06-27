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
    
    var currentWorkout:Workout?
    
    /**
    This method
    Inserts given workoutTitle into workoutTitleEditText
    */
    func initCell(currentWorkout:Workout){
        workoutTitleEditText.text = currentWorkout.workoutDetails.title
        self.currentWorkout = currentWorkout
    }
    
    /**
    This method
    Adds a target method to workoutTitleEditText
    The target method notices changes in the text
    */
    func initTextObserver(){
        workoutTitleEditText.addTarget(self, action: #selector(observeTitleChange(_:)), for: .editingChanged)
    }
    
    
    /**
    This method (@objc)
    Gives the text of exerciseNameEditText and sends it to delegateGetText
    */
    @objc func observeTitleChange(_ titleLabel:UITextField){
        currentWorkout?.workoutDetails.title = titleLabel.text ?? ""
    }
    
}


