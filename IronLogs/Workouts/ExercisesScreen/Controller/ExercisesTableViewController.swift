//
//  SingleWorkoutTableViewController.swift
//  9.4.2020LoginAndSaveToRealTimeDatabase
//
//  Created by Meron Skop on 13/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class ExercisesTableViewController: UITableViewController {
    
    var workoutIndex:Int?
    let mViewModel = ExercisesTableViewModel()
    
    let updateTitleBool = Box(Bool(false))
    
    override func viewDidAppear(_ animated: Bool) {
        WorkoutsInUse.shared().workouts.bind {[weak self] (workouts) -> Void in
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleExerciseTitleNib = UINib(nibName: "SingleExerciseTableViewCell", bundle: .main)
        tableView.register(singleExerciseTitleNib, forCellReuseIdentifier: "singleExerciseNib")
        
        let workoutTitleNib = UINib(nibName: "WorkoutTitleTableViewCell", bundle: .main)
        tableView.register(workoutTitleNib, forCellReuseIdentifier: "workoutTitleNib")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let exercisesIndex = workoutIndex else{
            return 1
        }
        guard let amountOfExercises = WorkoutsInUse.shared().workouts.value[exercisesIndex].exercises?.count else{
            return 1
        }
        return 1 + amountOfExercises
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutTitleNib", for: indexPath) as! WorkoutTitleTableViewCell
        cell.initTextObserver()
        cell.delegateGetText = self
        
        guard let exercisesIndex = workoutIndex else{
            return cell
        }
        
        updateTitleBool.bind {[weak self] (saveBool) in
            if saveBool{
            WorkoutsInUse.shared().workouts.value[exercisesIndex].workoutDetails.title = cell.getWorkoutTitle()
            self?.updateTitleBool.value = false
            }
        }
        
        guard let currentExercises = WorkoutsInUse.shared().workouts.value[exercisesIndex].exercises else{
            return cell
        }
        
        cell.initCell(workoutTitle:WorkoutsInUse.shared().workouts.value[exercisesIndex].workoutDetails.title)
        
        if indexPath.row >= 1 {
            let currentExercise = currentExercises[indexPath.row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: "singleExerciseNib", for: indexPath) as! SingleExerciseTableViewCell
            if let exerciseName = currentExercise.exerciseName {
                cell.initCell(exerciseName: exerciseName)
                
            }
            return cell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0{
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            guard let exercisesIndex = workoutIndex else{
                return
            }
            WorkoutsInUse.shared().workouts.value[exercisesIndex].exercises?.remove(at: indexPath.row-1)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSets", sender: indexPath.row - 1)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SetsTableViewController{
            if let exercisesIndex = sender as? Int{
                dest.exercisesIndex = exercisesIndex
                dest.workoutsIndex = self.workoutIndex
            }
        }
    }
    
    @IBAction func addExerciseButonTapped(_ sender: Any) {
        updateTitleBool.value = true
        guard let exercisesIndex = workoutIndex else{
            return
        }
        WorkoutsInUse.shared().workouts.value[exercisesIndex].exercises!.append(mViewModel.getNewExercise())
    }
    
    
    @IBAction func updateExercisesButtonTapped(_ sender: Any) {
        updateTitleBool.value = true
        //MARK: Make an animation that replaces the pencil while its trying to save
        guard let exercisesIndex = workoutIndex else{
            return
        }
        guard let currentExercises = WorkoutsInUse.shared().workouts.value[exercisesIndex].exercises else{
            return
        }
        let details = WorkoutsInUse.shared().workouts.value[workoutIndex!].workoutDetails
        mViewModel.updateWorkout(
            wId: details.wId,
            uid: details.userUid,
            title: details.title,
            exercises: currentExercises,
            collectDoneBool: {(done) in
                //Stop loading the pencil button
        })
    }
    
}

extension ExercisesTableViewController: editTextObserversDelegate{
    func getTextOnChange(text: String) {
        if workoutIndex != nil{
            WorkoutsInUse.shared().workouts.value[workoutIndex!].workoutDetails.title = text
        }
    }
    
}



