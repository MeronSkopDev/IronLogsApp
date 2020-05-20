//
//  Constants.swift
//  IronLogs
//
//  Created by Meron Skop on 17/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

struct Constants{
    
    struct SignUp{
           static let passwordInMap = "passwordInMapSignUp"
           static let confirmPasswordInMap = "confirmPasswordInMapSignUp"
           static let mailInMap = "mailInMapSignUp"
           static let nickNameInMap = "nickNameInMapSignUp"
       }
       
       struct LogIn {
           static let passwordInMap = "passwordInMapLogIn"
           static let mailInMap = "mailInMapLogIn"
       }
       
       struct WorkoutsTableView{
           static let workoutsCell = "workoutsCell"
       }
       
       struct DataBaseFireStoreConstants{
           ///Collections
           static let usersCollectionInDatabase = "Users"
           static let workoutsCollectionInDataBase = "Workouts"
           
           ///User related
           static let uidInDatabase = "uid"
           static let nickNameInDatabase = "nickName"
           static let titleInDataBase = "title"
           static let workoutIdInDatabase = "WId"
           static let dateOfCreationInWorkoutInDatabase = "dateOfCreation"
           
           ///Exercise related
           static let exercisesInDatabase = "exercises"
           static let singleExerciseInDatabase = "singleExercise"
           static let exerciseNameInDatabase = "exerciseName"
           
           ///Sets related
           static let setsInDatabase = "sets"
           static let repsIndataBase = "reps"
           static let setTypeInDatabase = "setType"
           static let weightInDatabase = "weight"
           static let rirInDataBase = "rir"
           
           ///SuperSets related
           static let superWeightInDataBase = "superWeight"
           static let superRepsInDataBase = "superReps"
           static let superNameInDataBase = "superName"
       }
}
