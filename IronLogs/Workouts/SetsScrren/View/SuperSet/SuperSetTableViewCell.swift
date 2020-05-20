//
//  SuperSetTableViewCell.swift
//  IronLogs
//
//  Created by Meron Skop on 29/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class SuperSetTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var currentExerciseLabel: UILabel!
    
    @IBOutlet weak var currentExerciseRepsEditText: UITextField!
    
    @IBOutlet weak var currentExerciseWeightEditText: UITextField!
    
    @IBOutlet weak var superExerciseRepsEditText: UITextField!
    
    @IBOutlet weak var superExerciseWeightEditText: UITextField!
    
    @IBOutlet weak var superExerciseNameEditText: UITextField!
    
    var cellSetIndex:Int?
    
    func initCell(currentExerciseName:String,set:Workout.Exercise.Set){
        currentExerciseLabel.text = currentExerciseName
        currentExerciseRepsEditText.text = "\(set.reps)"
        currentExerciseWeightEditText.text = "\(set.weight)"
        superExerciseNameEditText.text = set.superName
        superExerciseRepsEditText.text = "\(set.superReps ?? 0)"
        superExerciseWeightEditText.text = "\(set.superWeight ?? 0)"
    }
    func getIndex(currentSetIndex:Int){
        cellSetIndex = currentSetIndex
    }
    
    var delegate:SuperSetDelegate?
    
    func initDelegate(){
        currentExerciseRepsEditText.addTarget(self, action: #selector(observeRepsChange(_:)), for: .editingDidEnd)
        currentExerciseWeightEditText.addTarget(self, action: #selector(observeWeightChange(_:)), for: .editingDidEnd)
        superExerciseWeightEditText.addTarget(self, action: #selector(observeSuperWeightChange(_:)), for: .editingDidEnd)
        superExerciseRepsEditText.addTarget(self, action: #selector(observeSuperRepsChange(_:)), for: .editingDidEnd)
        superExerciseNameEditText.addTarget(self, action: #selector(observeSuperNameChange(_:)), for: .editingDidEnd)
    }
    
    @objc func observeWeightChange(_ titleLabel:UITextField){
        if let weight =  titleLabel.text {
            if cellSetIndex != nil{
                delegate?.getCurrentWeightOnChange(weight:Int(weight) ?? 0, currentSetIndex: cellSetIndex!)
            }
        }
    }
    
    @objc func observeSuperWeightChange(_ titleLabel:UITextField){
        if let weight =  titleLabel.text {
            if cellSetIndex != nil{
                delegate?.getSuperWeightOnChange(weight:Int(weight) ?? 0, currentSetIndex: cellSetIndex!)
            }
        }
    }
    
    @objc func observeRepsChange(_ titleLabel:UITextField){
        if let reps =  titleLabel.text {
            if cellSetIndex != nil{
                delegate?.getCurrentRepsOnChange(reps:Int(reps) ?? 0, currentSetIndex: cellSetIndex!)
            }
        }
    }
    
    @objc func observeSuperRepsChange(_ titleLabel:UITextField){
        if let reps =  titleLabel.text {
            if cellSetIndex != nil{
                delegate?.getSuperRepsOnChange(reps:Int(reps) ?? 0, currentSetIndex: cellSetIndex!)
            }
        }
    }
    
    @objc func observeSuperNameChange(_ titleLabel:UITextField){
        if cellSetIndex != nil{
            delegate?.getSuperNameOnChange(text: titleLabel.text ?? " ", currentSetIndex: cellSetIndex!)
        }
    }
    
}
