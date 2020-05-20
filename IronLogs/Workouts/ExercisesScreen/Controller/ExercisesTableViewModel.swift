//
//  SingleWorkoutTableViewModel.swift
//  9.4.2020LoginAndSaveToRealTimeDatabase
//
//  Created by Meron Skop on 13/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

struct ExercisesTableViewModel {
    
    func updateWorkout(wId:String,uid:String,title:String,exercises:[Workout.Exercise], collectDoneBool: @escaping (Bool) -> Void){
                FSData.addAndMergeWorkout(
                uid: uid,
                wId: wId,
                exercises: Workout.Exercise.makeExercisesFireStoreReady(exercises: exercises),
                title: title,
                    done: { (doneBool) in
                        collectDoneBool(doneBool)
                })
    }
    
    func updateTitle(uid:String,wId:String,title:String){
        FSData.addAndMergeWorkoutTitle(uid: uid, wId: wId, newTitle: title)
    }
    
    func getNewExercise() -> Workout.Exercise{
        return Workout.Exercise(
        exerciseName: "Exercise Name",
        sets: [Workout.Exercise.Set(
            setType: Workout.Exercise.Set.SetType.regularSet ,
            weight: 0,
            reps: 0,
            rir: nil)])
    }
}
