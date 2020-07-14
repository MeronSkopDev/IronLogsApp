//
//  RegularSetTableViewCell.swift
//  9.4.2020LoginAndSaveToRealTimeDatabase
//
//  Created by Meron Skop on 19/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class RegularSetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weightEditText: UITextField!
    
    @IBOutlet weak var repsEditText: UITextField!
    
    var cellSetIndex:Int?
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var currentSet:Workout.Exercise.Set?
    
    /**
     This method
     Inserts given reps and weights into weightEditText and repsEditText respectivly
     Recives the index of the set in the Workout.Exercise.Set that this cell corresponds with
     */
    func initCell(currentSet:Workout.Exercise.Set){
        self.currentSet = currentSet
        weightEditText.text = "\(currentSet.weight)"
        repsEditText.text = "\(currentSet.reps)"
    }
    
    /**
     This method
     Adds a target method to weightEditText and repsEditText
     The target method notices changes in the text
     */
    func initTextObserver(){
        weightEditText.addTarget(self, action: #selector(observeWeightChange(_:)), for: .editingChanged)
        repsEditText.addTarget(self, action: #selector(observeRepsChange(_:)), for: .editingChanged)
    }
    
    /**
     This method (@objc)
     Gives the text of exerciseNameEditText and sends it to delegateGetWeightAndReps
     Sends back to "SingleExerciseTableViewController"
     */
    @objc func observeWeightChange(_ titleLabel:UITextField){
        if let weight =  titleLabel.text {
            currentSet?.weight = Int(weight) ?? 0
        }
    }
    
    /**
     This method (@objc)
     Gives the text of exerciseNameEditText and sends it to delegateGetWeightAndReps
     Sends back to "SingleExerciseTableViewController"
     */
    @objc func observeRepsChange(_ titleLabel:UITextField){
        if let reps =  titleLabel.text {
            currentSet?.reps = Int(reps) ?? 0
        }
    }
    
    
    
}
