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
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
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
        
        guard let exercisesIndex = workoutIndex else{
            return cell
        }
        
        guard let currentExercises = WorkoutsInUse.shared().workouts.value[exercisesIndex].exercises else{
            return cell
        }
        
        cell.initCell(currentWorkout:WorkoutsInUse.shared().workouts.value[exercisesIndex])
        
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
        guard let exercisesIndex = workoutIndex else{
            return
        }
        WorkoutsInUse.shared().workouts.value[exercisesIndex].exercises!.append(mViewModel.getNewExercise())
        tableView.beginUpdates()
        tableView.insertRows(at:
            [(NSIndexPath(row: WorkoutsInUse.shared().workouts.value[exercisesIndex].exercises!.count ,
                          section: 0) as IndexPath)], with: .automatic)
        tableView.endUpdates()
    }
    
    
    @IBAction func updateExercisesButtonTapped(_ sender: Any) {
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
        })
    }
    
}


