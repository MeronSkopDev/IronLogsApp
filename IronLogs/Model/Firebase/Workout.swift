//
//  Workout.swift
//  IronLogs
//
//  Created by Meron Skop on 17/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation
import FirebaseAuth
import PKHUD

class Workout{
    
    init(workoutDetails:WorkoutDetails,
         exercises:[Workout.Exercise]?){
        self.workoutDetails = workoutDetails
        self.exercises = exercises
    }
    
    var workoutDetails:WorkoutDetails
    
    struct WorkoutDetails{
        var title:String
        let dateOfCreation:String
        let wId:String
        let userUid:String
    }
    
    var exercises:[Exercise]?
    
    class Exercise{
        
        init(exerciseName:String?,sets:[Set]?){
            self.exerciseName = exerciseName
            self.sets = sets
        }
        
        var exerciseName:String?
        var sets:[Set]?
        
        /**
         This method
         Recives an [Workout.Exercise]
         It turns what it get to a [String:Any] ready in format for FireStore
         */
        static func makeExercisesFireStoreReady(exercises:[Exercise]) -> [[String:Any]]{
            
            var exercisesToAdd = [[String:Any]]()
            
            for singleExercise in exercises{
                let exerciseName = singleExercise.exerciseName
                if let sets = singleExercise.sets{
                    let setsToAdd = Set.makeSetsFireStoreReady(sets: sets)
                    exercisesToAdd.append(
                        [Constants.DataBaseFireStoreConstants.setsInDatabase:setsToAdd,
                         Constants.DataBaseFireStoreConstants.exerciseNameInDatabase:exerciseName])
                }else{
                    exercisesToAdd.append(
                        [Constants.DataBaseFireStoreConstants.exerciseNameInDatabase:exerciseName])
                }
                
                
            }
            
            return exercisesToAdd
            
        }
        
        
        
        //MARK: Add special sets fields
        class Set{
            
            init(setType:SetType,weight:Int, reps:Int){
                self.setType = setType
                self.weight = weight
                self.reps = reps
            }
            
            init(setType:SetType,weight:Int, reps:Int, superReps:Int, superWeight:Int, superName:String){
                self.setType = setType
                self.weight = weight
                self.reps = reps
                self.superName = superName
                self.superReps = superReps
                self.superWeight = superWeight
            }
            
            let setType:SetType
            var weight:Int
            var reps:Int
            var rir:Int?
            
            ///SuperSet variables
            var superReps:Int?
            var superWeight:Int?
            var superName:String?
            
            /**
             This method
             Gets [Workout.Exercise.Set]
             It turns what it gets to a [String:Any] ready in format for FireStore
             */
            static func makeSetsFireStoreReady(sets:[Set]) -> [[String:Any]]{
                var setsToReturn = [[String:Any]]()
                for singleSet in sets{
                    let weight = singleSet.weight
                    let reps = singleSet.reps
                    let setType = singleSet.setType.rawValue
                    
                    switch setType {
                    case Set.SetType.regularSet.rawValue:
                        let set = [
                            Constants.DataBaseFireStoreConstants.weightInDatabase:weight,
                            Constants.DataBaseFireStoreConstants.repsIndataBase:reps,
                            Constants.DataBaseFireStoreConstants.setTypeInDatabase:setType] as [String : Any]
                        setsToReturn.append(set)
                        break
                        
                    case Set.SetType.superSet.rawValue:
                        let superReps = singleSet.superReps ?? 0
                        let superWeight = singleSet.superWeight ?? 0
                        let superName = singleSet.superName ?? " "
                        
                        let set = [
                            Constants.DataBaseFireStoreConstants.weightInDatabase:weight,
                            Constants.DataBaseFireStoreConstants.repsIndataBase:reps,
                            Constants.DataBaseFireStoreConstants.superNameInDataBase:superName,
                            Constants.DataBaseFireStoreConstants.superRepsInDataBase:superReps,
                            Constants.DataBaseFireStoreConstants.superWeightInDataBase:superWeight,
                            Constants.DataBaseFireStoreConstants.setTypeInDatabase:setType] as [String : Any]
                        setsToReturn.append(set)
                        break
                    default:
                        break
                    }
                    
                    
                }
                
                return setsToReturn
            }
            
            
            //MARK: Add special sets cases
            enum SetType:String{
                case regularSet = "regular"
                case superSet = "super"
            }
        }
    }
    
}

class WorkoutsInUse:ShowHud{
    private static var currentUserUid:String{
        guard let uid = Auth.auth().currentUser?.uid else{
            return " "
        }
        return uid
    }
    
    private static var workoutsInUse:WorkoutsInUse = {
        HUD.show(.progress)
        var workoutsInUse = WorkoutsInUse()
        
        FSData.getUserWorkouts(uid: currentUserUid) { (workouts) in
            guard let workouts = workouts else{
                HUD.flash(.labeledError(title: "Couldent get workouts", subtitle: nil))
                return
            }
            workoutsInUse.workouts.value = workouts
        }
        HUD.flash(.success)
        return workoutsInUse
    }()
    
    private init() {}
    
    var workouts = Box([Workout]())
    
    static func shared() -> WorkoutsInUse{
        return workoutsInUse
    }
    
    static func clearData(){
        workoutsInUse.workouts.value = []
    }
    
    static func loadData(complition: @escaping (Bool) -> Void){
        FSData.getUserWorkouts(uid: currentUserUid) { (workouts) in
            guard let workouts = workouts else{
                HUD.flash(.labeledError(title: "Couldent get workouts", subtitle: nil))
                return
            }
            workoutsInUse.workouts.value = workouts
            complition(true)
        }
    }
    
    
    func getExercises(workoutsIndex:Int) -> [Workout.Exercise]?{
        return workouts.value[workoutsIndex].exercises
    }
    
    func getSets(workoutsIndex:Int, exercisesIndex:Int) -> [Workout.Exercise.Set]? {
        return workouts.value[workoutsIndex].exercises?[exercisesIndex].sets
    }
    
}

