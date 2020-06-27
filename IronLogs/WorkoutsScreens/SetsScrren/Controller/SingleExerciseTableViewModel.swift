//
//  SingleExerciseTableViewModel.swift
//  9.4.2020LoginAndSaveToRealTimeDatabase
//
//  Created by Meron Skop on 17/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

struct SetsViewModel{
    func getNewSet() -> Workout.Exercise.Set{
        return Workout.Exercise.Set(
            setType: Workout.Exercise.Set.SetType.regularSet,
            weight: 0,
            reps: 0
            )
    }
    
    func getNewSuperSet() -> Workout.Exercise.Set{
        return Workout.Exercise.Set(
            setType: Workout.Exercise.Set.SetType.superSet,
            weight: 0,
            reps: 0,
            superReps: 0,
            superWeight: 0,
            superName:"Exercise name")
        
    }
    
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
    
}
