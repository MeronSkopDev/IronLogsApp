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
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var currentSet:Workout.Exercise.Set?
    
    func initCell(currentExerciseName:String,currentSet:Workout.Exercise.Set){
        self.currentSet = currentSet
        currentExerciseLabel.text = currentExerciseName
        currentExerciseRepsEditText.text = "\(currentSet.reps)"
        currentExerciseWeightEditText.text = "\(currentSet.weight)"
        superExerciseNameEditText.text = currentSet.superName
        superExerciseRepsEditText.text = "\(currentSet.superReps ?? 0)"
        superExerciseWeightEditText.text = "\(currentSet.superWeight ?? 0)"
    }
    
    var delegate:SuperSetDelegate?
    
    func initDelegate(){
        currentExerciseRepsEditText.addTarget(self, action: #selector(observeRepsChange(_:)), for: .editingChanged)
        currentExerciseWeightEditText.addTarget(self, action: #selector(observeWeightChange(_:)), for: .editingChanged)
        superExerciseWeightEditText.addTarget(self, action: #selector(observeSuperWeightChange(_:)), for: .editingChanged)
        superExerciseRepsEditText.addTarget(self, action: #selector(observeSuperRepsChange(_:)), for: .editingChanged)
        superExerciseNameEditText.addTarget(self, action: #selector(observeSuperNameChange(_:)), for: .editingChanged)
    }
    
    
    @objc func observeWeightChange(_ titleLabel:UITextField){
        if let weight =  titleLabel.text {
            currentSet?.weight = Int(weight) ?? 0
        }
    }
    
    @objc func observeSuperWeightChange(_ titleLabel:UITextField){
        if let superWeight =  titleLabel.text {
            currentSet?.superWeight = Int(superWeight) ?? 0
        }
    }
    
    @objc func observeRepsChange(_ titleLabel:UITextField){
        if let reps =  titleLabel.text {
            currentSet?.reps = Int(reps) ?? 0
        }
    }
    
    @objc func observeSuperRepsChange(_ titleLabel:UITextField){
        if let superReps =  titleLabel.text {
            currentSet?.superReps = Int(superReps) ?? 0
        }
    }
    
    @objc func observeSuperNameChange(_ titleLabel:UITextField){
        currentSet?.superName = titleLabel.text ?? " "
    }
    
}
