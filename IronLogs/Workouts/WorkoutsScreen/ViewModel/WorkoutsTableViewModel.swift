//
//  WorkoutsTableViewModel.swift
//  9.4.2020LoginAndSaveToRealTimeDatabase
//
//  Created by Meron Skop on 11/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

import Firebase


struct WorkoutsTableViewModel{
    
    
    func getNewWorkout(workoutName:String) -> Workout{
        let workoutToReturn = Workout(
            workoutDetails:
            Workout.WorkoutDetails(
                title: workoutName,
                dateOfCreation: getDateFormatted(),
                wId: RandomIdGen.generateId(),
                userUid:  Auth.auth().currentUser!.uid),
            exercises: [Workout.Exercise(exerciseName: "Exercise Name",
                                         sets: [Workout.Exercise.Set(
                                            setType: Workout.Exercise.Set.SetType.regularSet,
                                            weight: 0, reps: 0, rir: 0)])])
        return workoutToReturn
    }
    
    func createNewWorkout(uid:String,wId:String,title:String,date:String,exercises:[Workout.Exercise]){
        FSData.createNewWorkout(
        uid: Auth.auth().currentUser!.uid,
        title: title,
        wId: wId,
        dateOfCreation: date,
        exercises: Workout.Exercise.makeExercisesFireStoreReady(exercises: exercises)) { (err) in
            if err != nil{
                print(err!.localizedDescription)
            }
        }
    }
    
    func updateWorkouts(workouts:[Workout], collectDoneBool: @escaping (Bool) -> Void){
        for singleWorkout in workouts{
            if singleWorkout.exercises != nil{
            FSData.addAndMergeWorkout(
                uid: singleWorkout.workoutDetails.userUid,
                wId: singleWorkout.workoutDetails.wId,
                exercises: Workout.Exercise.makeExercisesFireStoreReady(
                    exercises: singleWorkout.exercises!),
                title: singleWorkout.workoutDetails.title,
                    done: { (doneBool) in
                        collectDoneBool(doneBool)
                })
            }
        }
        
    }
    
    func getDateFormatted() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: Date())
    }
    
}
