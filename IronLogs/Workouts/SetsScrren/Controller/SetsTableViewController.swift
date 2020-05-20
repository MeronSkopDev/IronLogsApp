//
//  SingleExerciseTableViewController.swift
//  9.4.2020LoginAndSaveToRealTimeDatabase
//
//  Created by Meron Skop on 17/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class SetsTableViewController: UITableViewController {
    
    var exercisesIndex:Int?
    var workoutsIndex:Int?
    let mViewModel = SetsViewModel()
    
    let updateExerciseTitleBool = Box(Bool(false))
    var isCurrentlyDeleating = false
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidAppear(_ animated: Bool) {
        //MARK: Think of a smart way to populate the cells instead of reloading the tableView constantly
            //Need to populate when: 1) a cell contents is changed 2) a cell is added 3) [For superSets] when the exercise name changes
        WorkoutsInUse.shared().workouts.bind {[weak self] (workouts) -> Void in
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exerciseNameNib = UINib(nibName: "ExerciseNameTableViewCell", bundle: .main)
        tableView.register(exerciseNameNib, forCellReuseIdentifier: "exerciseNameNib")
        
        let regularSetNib = UINib(nibName: "RegularSetTableViewCell", bundle: .main)
        tableView.register(regularSetNib, forCellReuseIdentifier: "regularSetNib")
        
        let superSetNib = UINib(nibName: "SuperSetTableViewCell", bundle: .main)
        tableView.register(superSetNib, forCellReuseIdentifier: "superSetNib")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let workoutsIndex = workoutsIndex else{
            return 1
        }
        guard let setIndex = exercisesIndex else{
            return 1
        }
        guard let amountOfSets = WorkoutsInUse.shared().workouts.value[workoutsIndex].exercises?[setIndex].sets?.count else{
            return 1
        }
        return 1 + amountOfSets
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseNameNib", for: indexPath) as! ExerciseNameTableViewCell
        cell.initTextObserver()
        cell.delegateGetText = self
        
        
        if let workoutsIndex = workoutsIndex {
            
            
            if let exercisesIndex = exercisesIndex{
                
                updateExerciseTitleBool.bind {[weak self] (saveBool) in
                    if saveBool{
                        WorkoutsInUse.shared()
                            .workouts.value[workoutsIndex]
                            .exercises?[exercisesIndex]
                            .exerciseName = cell.getExerciseName()
                        self?.updateExerciseTitleBool.value = false
                    }
                }
                
                
                if let exerciseName = WorkoutsInUse.shared()
                    .workouts.value[workoutsIndex]
                    .exercises?[exercisesIndex]
                    .exerciseName {
                    cell.initCell(exerciseName: exerciseName)
                }
                
                if let sets = WorkoutsInUse.shared().workouts.value[workoutsIndex].exercises?[exercisesIndex].sets{
                    ///If the row is grater then one we show sets
                    if indexPath.row >= 1{
                        let currentSet = sets[indexPath.row - 1]
                        let setType = currentSet.setType
                        
                        ///Here we check if the set to display is a regular set or a special one
                        switch setType {
                        case Workout.Exercise.Set.SetType.regularSet:
                            let cell = tableView.dequeueReusableCell(withIdentifier: "regularSetNib", for: indexPath) as! RegularSetTableViewCell
                            cell.getIndex(setIndex:indexPath.row - 1)
                            cell.initCell(set: currentSet)
                            cell.initTextObserver()
                            cell.delegateGetWeightAndReps = self
                            return cell
                            
                        case Workout.Exercise.Set.SetType.superSet:
                            let cell = tableView.dequeueReusableCell(withIdentifier: "superSetNib", for: indexPath) as! SuperSetTableViewCell
                            cell.getIndex(currentSetIndex: indexPath.row - 1)
                            cell.initCell(
                                currentExerciseName: WorkoutsInUse.shared()
                                    .workouts.value[workoutsIndex]
                                    .exercises?[exercisesIndex]
                                    .exerciseName ?? " ",
                                set: currentSet)
                            cell.initDelegate()
                            cell.delegate = self
                            return cell
                        default:
                            break
                        }
                    }
                }
            }
        }
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        ///Here we make sure the user cannot delete the cell that holds the name of the exercise
        if indexPath.row == 0{
            return false
        }
        return true
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            isCurrentlyDeleating = true
            tableView.beginUpdates()
            guard let workoutsIndex = workoutsIndex else{
                return
            }
            guard let exercisesIndex = exercisesIndex else{
                return
            }
            WorkoutsInUse.shared()
                .workouts.value[workoutsIndex]
                .exercises?[exercisesIndex]
                .sets?.remove(at: indexPath.row - 1)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            isCurrentlyDeleating = false
            //MARK: Find a way to fix the bug where the app crashes when you try to delete a cell in index n+x (x>=1) while deleteing cell in index n
        }
    }
    
    /**
     This method
     Saves any changes the user made in the database
     */
    @IBAction func updateSetsTapped(_ sender: UIBarButtonItem) {
        updateExerciseTitleBool.value = true
        saveButton.isEnabled = false
        guard let workoutsIndex = workoutsIndex else{
            return
        }
        guard let currentExercises = WorkoutsInUse.shared().workouts.value[workoutsIndex].exercises else{
            return
        }
        let details = WorkoutsInUse.shared().workouts.value[workoutsIndex].workoutDetails
        mViewModel.updateWorkout(
            wId: details.wId,
            uid: details.userUid,
            title: details.title,
            exercises: currentExercises,
            collectDoneBool: {[weak self](done) in
                if done{
                    self?.saveButton.isEnabled = true
                    self?.showSuccsess()
                }
        })
    }
    
    /**
     This method
     Adds a new set to "WorkoutsInUse.shared()" in the exercise the user is currently looking at
     */
    @IBAction func addSetTapped(_ sender: Any) {
        
        updateExerciseTitleBool.value = true
        createAndShowSetChoiceSheet()
        
    }
    
    /**
     This method
     Creates an "UIAlertController" that lets the user choose which set he want to add
     */
    func createAndShowSetChoiceSheet(){
        let setChoiceSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        ///This is th option to add a regualr set
        let addRegularSet = UIAlertAction(title: "Regular Set", style: .default) {[weak self] (action) in
            if self?.workoutsIndex != nil{
                if self?.exercisesIndex != nil{
                    WorkoutsInUse.shared()
                        .workouts.value[(self?.workoutsIndex)!]
                        .exercises?[(self?.exercisesIndex)!]
                        .sets?.append((self?.mViewModel.getNewSet())!)
                    
                }
            }
        }
        ///This is th option to add a super set
        let addSuperSet = UIAlertAction(title: "Super set", style: .default) {[weak self] (action) in
            if self?.workoutsIndex != nil{
                if self?.exercisesIndex != nil{
                    WorkoutsInUse.shared()
                        .workouts.value[(self?.workoutsIndex)!]
                        .exercises?[(self?.exercisesIndex)!]
                        .sets?.append((self?.mViewModel.getNewSuperSet())!)
                }
            }
        }
        setChoiceSheet.addAction(addRegularSet)
        setChoiceSheet.addAction(addSuperSet)
        setChoiceSheet.addAction(cancel)
        present(setChoiceSheet, animated: true)
    }
    
}

extension SetsTableViewController: editTextObserversDelegate{
    
    /**
     This method
     Updates the exerciseName in "WorkoutsInUse.shared()"
     */
    func getTextOnChange(text: String) {
        if workoutsIndex != nil{
            if exercisesIndex != nil{
                WorkoutsInUse.shared()
                    .workouts
                    .value[workoutsIndex!]
                    .exercises?[exercisesIndex!]
                    .exerciseName = text
            }
        }
    }
    
}

