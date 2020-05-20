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
    
    /**
     This method
     Inserts given reps and weights into weightEditText and repsEditText respectivly
     Recives the index of the set in the Workout.Exercise.Set that this cell corresponds with
     */
    func initCell(set:Workout.Exercise.Set){
        weightEditText.text = "\(set.weight)"
        repsEditText.text = "\(set.reps)"
    }
    func getIndex(setIndex:Int){
        cellSetIndex = setIndex
    }
    
    var delegateGetWeightAndReps:WeightAndRepsObservationDelegate?
    
    /**
    This method
    Adds a target method to weightEditText and repsEditText
    The target method notices changes in the text
    */
    func initTextObserver(){
        weightEditText.addTarget(self, action: #selector(observeWeightChange(_:)), for: .editingDidEnd)
        repsEditText.addTarget(self, action: #selector(observeRepsChange(_:)), for: .editingDidEnd)
    }
    
    /**
    This method (@objc)
    Gives the text of exerciseNameEditText and sends it to delegateGetWeightAndReps
    Sends back to "SingleExerciseTableViewController"
    */
    @objc func observeWeightChange(_ titleLabel:UITextField){
        if let weight =  titleLabel.text {
            if cellSetIndex != nil{
                delegateGetWeightAndReps?.getWeightOnChange(weight:Int(weight) ?? 0, currentSetIndex: cellSetIndex!)
            }
        }
    }
    
    /**
    This method (@objc)
    Gives the text of exerciseNameEditText and sends it to delegateGetWeightAndReps
    Sends back to "SingleExerciseTableViewController"
    */
    @objc func observeRepsChange(_ titleLabel:UITextField){
        if let reps =  titleLabel.text {
            if cellSetIndex != nil{
                delegateGetWeightAndReps?.getRepsOnChange(reps:Int(reps) ?? 0, currentSetIndex: cellSetIndex!)
            }
        }
    }
    
}
