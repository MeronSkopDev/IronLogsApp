//
//  WorkoutsTableViewController.swift
//  IronLogs
//
//  Created by Meron Skop on 17/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class WorkoutsTableViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidAppear(_ animated: Bool) {
        WorkoutsInUse.loadData()
        /**
         This observes "WorkoutsInUse.shared().workouts"
         Any changes made to "WorkoutsInUse.shared().workouts" will reload this tableView
         */
        WorkoutsInUse.shared().workouts.bind {[weak self] (workouts) -> Void in
            self?.tableView.reloadData()
            
        }
        
        
        
    }
    
    private let mViewModel = WorkoutsTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return WorkoutsInUse.shared().workouts.value.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.WorkoutsTableView.workoutsCell, for: indexPath)
        
        let currentWorkout = WorkoutsInUse.shared().workouts.value[indexPath.row]
        
        
        if let cell = cell as? WorkoutsTableViewCell{
            
            cell.updateCell(workoutDetails: currentWorkout.workoutDetails)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            let currentWorkoutDetails = WorkoutsInUse.shared().workouts.value[indexPath.row].workoutDetails
            WorkoutsInUse.shared().workouts.value.remove(at: indexPath.row)
            FSData.deleteWorkoutDocument(uid:currentWorkoutDetails.userUid , wId: currentWorkoutDetails.wId)
            tableView.endUpdates()
        } else if editingStyle == .insert {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toExercises", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ExercisesTableViewController{
            if let workoutIndex = sender as? Int{
                //Here we pass the index of the workout the user tapped
                dest.workoutIndex = workoutIndex
            }
        }
    }
    
    
    /**
     This method
     Saves any changes the user made in the database
     */
    @IBAction func updateWorkouts(_ sender: Any) {
        saveButton.isEnabled = false
        mViewModel.updateWorkouts(
            workouts: WorkoutsInUse.shared().workouts.value,
            collectDoneBool: {[weak self](done) in
                if done{
                    self?.saveButton.isEnabled = true
                }
        })
    }
    
    /**
     This method
     Adds a new Workout to "WorkoutsInUse.shared()"
     Creates a new Workout document in the database
     */
    @IBAction func plusPressed(_ sender: UIBarButtonItem) {
        WorkoutsInUse.shared().workouts.value.append(mViewModel.getNewWorkout(workoutName:"Workout"))
        if let currentWorkout = WorkoutsInUse.shared().workouts.value.last{
            mViewModel.createNewWorkout(
                uid: Auth.auth().currentUser!.uid,
                wId: currentWorkout.workoutDetails.wId,
                title: currentWorkout.workoutDetails.title,
                date: currentWorkout.workoutDetails.dateOfCreation,
                exercises: currentWorkout.exercises!)
        }
        
    }
    
    
    @IBAction func homeButtonTapped(_ sender: UIBarButtonItem) {
        WorkoutsInUse.clearData()
        let homeStoryboard = UIStoryboard(name: "Home", bundle: .main)
        Router.shared.window?.rootViewController = homeStoryboard.instantiateInitialViewController()
    }
    
    
}
