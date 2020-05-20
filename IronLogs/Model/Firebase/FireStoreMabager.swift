//
//  FireStoreMabager.swift
//  IronLogs
//
//  Created by Meron Skop on 17/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation
import FirebaseFirestore

///This part of the struct is to get data
struct FSData{
    
    static private let fireStoreDatabase = Firestore.firestore()
    
    static func getUserNickName(uid: String, collector: @escaping (String?) -> Void){
        
        DispatchQueue.global(qos: .userInteractive).async {
            fireStoreDatabase.collection(Constants.DataBaseFireStoreConstants.usersCollectionInDatabase).whereField(Constants.DataBaseFireStoreConstants.uidInDatabase, isEqualTo: uid).getDocuments {
                (qs, error) in
                guard let qs = qs else{
                    return
                }
                
                let userNickName = qs.documents[0].data()[Constants.DataBaseFireStoreConstants.nickNameInDatabase] as? String
                DispatchQueue.main.async {
                    collector(userNickName)
                }
            }
        }
    }
    
    
    //MARK: Add a closure that can recive an error
    /**
     This method
     Gets a users document with the correlating uid
     */
    static func getUserDocumentId(uid:String,collector: @escaping (String) -> Void){
        DispatchQueue.global(qos: .userInitiated).async{
            fireStoreDatabase
                .collection(Constants.DataBaseFireStoreConstants.usersCollectionInDatabase)
                .whereField(Constants.DataBaseFireStoreConstants.uidInDatabase, isEqualTo:  uid).getDocuments {
                    (snapShot, err) in
                    if err != nil{
                        print(err!.localizedDescription)
                    }else{
                        guard let snapShot = snapShot else{
                            print("Couldnt get snapShot in getUserDocumentId")
                            return
                        }
                        DispatchQueue.main.async {
                            collector(snapShot.documents[0].documentID)
                        }
                    }
            }
        }
    }
    
    /**
     This method
     Uses a given uid, wId and the mothod "getUserDocumentId"(inside it)
     It finds a users specific workout by its date
     */
    static func getUserSingleWorkoutDocumentId(uid:String,wId:String, collector: @escaping (String,String) -> Void){
        
        getUserDocumentId(uid: uid) { (userDoc) in
            fireStoreDatabase
                .collection(Constants.DataBaseFireStoreConstants.usersCollectionInDatabase)
                .document(userDoc)
                .collection(Constants.DataBaseFireStoreConstants.workoutsCollectionInDataBase)
                .whereField(Constants.DataBaseFireStoreConstants.workoutIdInDatabase, isEqualTo: wId)
                .getDocuments { (snapShot, err) in
                    if err != nil{
                        print(err!.localizedDescription)
                    }else{
                        DispatchQueue.main.async {
                            guard let snapShot = snapShot else{
                                print("Couldnt get snapShot in getUserSingleWorkoutDocumentId")
                                return
                            }
                            collector(userDoc,snapShot.documents[0].documentID)
                        }
                    }
            }
        }
        
    }
    
    /**
     This method
     Gets the user with the corresponding uid's workouts as [Workout]
     */
    static func getUserWorkouts(uid:String, collector: @escaping ([Workout]?) -> Void){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            fireStoreDatabase.collectionGroup(Constants.DataBaseFireStoreConstants.workoutsCollectionInDataBase).whereField(Constants.DataBaseFireStoreConstants.uidInDatabase, isEqualTo: uid).getDocuments { (snapShot, error) in
                if error != nil{
                    print(error!.localizedDescription)
                }
                
                guard let snapShot = snapShot else{
                    return
                }
                
                var workouts = [Workout]()
                
                let detailsDocuments = snapShot.documents
                
                for document in detailsDocuments{
                    let currentData = document.data()
                    
                    let details = getWorkoutDetails(workoutDetailsData: currentData)
                    
                    let exercises = getExercises(workoutData: currentData)
                    
                    workouts.append(Workout(workoutDetails: details, exercises: exercises))
                }
                
                DispatchQueue.main.async {
                    collector(workouts)
                }
            }
        }
    }
    
    /**
     This method
     Recives a document from Workouts from firestore
     And inserts its uid, date and title into a "Workout.WorkoutDetails" object
     */
    static func getWorkoutDetails(workoutDetailsData data:[String:Any]) -> Workout.WorkoutDetails{
        let details  = Workout.WorkoutDetails(
            title:(data[Constants.DataBaseFireStoreConstants.titleInDataBase] as? String)!,
            dateOfCreation:(data[Constants.DataBaseFireStoreConstants.dateOfCreationInWorkoutInDatabase] as? String)!,
            wId:(data[Constants.DataBaseFireStoreConstants.workoutIdInDatabase] as? String)!,
            userUid:(data[Constants.DataBaseFireStoreConstants.uidInDatabase] as? String)!)
        return details
    }
    
    /**
     This method
     Recives a "sets" array from firestore
     And inserts those sets into [Workout.Exercise.Set]
     */
    static func getSets(setsData data:[[String:Any]]) -> [Workout.Exercise.Set]?{
        var sets = [Workout.Exercise.Set]()
        
        for set in data{
            guard let setType = set[Constants.DataBaseFireStoreConstants.setTypeInDatabase] as? String else{
                print("Couldent get Set type")
                return nil
            }
            
            ///Here we check what set type we got
            switch setType {
            case Workout.Exercise.Set.SetType.regularSet.rawValue:
                guard let weight = set[Constants.DataBaseFireStoreConstants.weightInDatabase] as? Int else{
                    print("Couldent get weight")
                    return nil
                }
                
                guard let reps = set[Constants.DataBaseFireStoreConstants.repsIndataBase] as? Int else {
                    print("Couldent get reps")
                    return nil
                }
                
                let singleSet = Workout.Exercise.Set(
                    setType: .regularSet,
                    weight: weight,
                    reps: reps)
                
                sets.append(singleSet)
                break
                
            case Workout.Exercise.Set.SetType.superSet.rawValue:
                guard let weight = set[Constants.DataBaseFireStoreConstants.weightInDatabase] as? Int else{
                    print("Couldent get weight")
                    return nil
                }
                
                guard let reps = set[Constants.DataBaseFireStoreConstants.repsIndataBase] as? Int else {
                    print("Couldent get reps")
                    return nil
                }
                
                guard let superReps = set[Constants.DataBaseFireStoreConstants.superRepsInDataBase] as? Int else{
                    print("Couldent get superReps")
                    return nil
                }
                
                guard let superWeight = set[Constants.DataBaseFireStoreConstants.superWeightInDataBase] as? Int else{
                    print("Couldent get superWeight")
                    return nil
                }
                
                guard let superName = set[Constants.DataBaseFireStoreConstants.superNameInDataBase] as? String else{
                    print("Couldent get superName")
                    return nil
                }
                
                let superSet = Workout.Exercise.Set(
                    setType: .superSet,
                    weight: weight,
                    reps: reps,
                    superReps: superReps,
                    superWeight: superWeight,
                    superName: superName)
                
                sets.append(superSet)
                
                break
            default:
                print("Wrong set Type")
                return nil
            }
        }
        return sets
    }
    
    
    /**
     This method
     Recives a document from Workouts from firestore
     And inserts its exercises into [Workout.Exercise]
     */
    static func getExercises(workoutData data:[String:Any]) -> [Workout.Exercise]?{
        var exercises = [Workout.Exercise]()
        
        guard let exercisesData = data[Constants.DataBaseFireStoreConstants.exercisesInDatabase] as? [[String:Any]] else {
            print("Couldent get exercises")
            return nil
        }
        
        for exercise in exercisesData{
            
            guard let exerciseName = exercise[Constants.DataBaseFireStoreConstants.exerciseNameInDatabase] as? String else{
                print("Couldent get exerciseName")
                return nil
            }
            
            guard let setsData = exercise[Constants.DataBaseFireStoreConstants.setsInDatabase] as? [[String:Any]] else{
                print("Couldent get sets")
                return nil
            }
            
            guard let sets = getSets(setsData: setsData) else{
                return nil
            }
            
            let singleExercise = Workout.Exercise(exerciseName: exerciseName, sets: sets)
            exercises.append(singleExercise)
        }
        return exercises
    }
    
}




///This part of the struct is to write data
extension FSData{
    
    //MARK: Add a closure that can recive an error
    static func saveUsersNickNameAndUid(uid:String,nickName:String){
        fireStoreDatabase.collection("Users").addDocument(data: [Constants.DataBaseFireStoreConstants.nickNameInDatabase:nickName,Constants.DataBaseFireStoreConstants.uidInDatabase:uid]){ (error) in
            if error != nil{
                print(error!.localizedDescription)
            }
        }
    }
    
    
    
    /**
     This method
     Crates a "Workouts" collection witih a "Users" document with the fitting uid and adds a document with 2 fields to it
     If a "Workouts" collection allready exists it just within that document it adds a new document with 3 fields within it
     */
    static func createNewWorkout(uid:String,title:String,wId:String,dateOfCreation:String,exercises:[[String:Any]],collector: @escaping (Error?) -> Void){
        getUserDocumentId(uid: uid) { (documentID) in
            fireStoreDatabase.collection(Constants.DataBaseFireStoreConstants.usersCollectionInDatabase).document(documentID).collection(Constants.DataBaseFireStoreConstants.workoutsCollectionInDataBase).addDocument(
                data: [
                    Constants.DataBaseFireStoreConstants.dateOfCreationInWorkoutInDatabase:dateOfCreation,
                    Constants.DataBaseFireStoreConstants.uidInDatabase:uid,
                    Constants.DataBaseFireStoreConstants.titleInDataBase:title,
                    Constants.DataBaseFireStoreConstants.workoutIdInDatabase:wId,
                    Constants.DataBaseFireStoreConstants.exercisesInDatabase:exercises
                ], completion:{ (err) in
                    DispatchQueue.main.async {
                        if err != nil{
                            collector(err)
                        }
                    }
            })
        }
    }
    
    
    
    /**
     This method
     Recives an allready converted "Workout"
     And merges its contents into the workout document with the corresponding uid and date
     */
    static func addAndMergeWorkout(uid:String,wId:String,exercises:[[String:Any]],title:String?, done:@escaping (Bool) -> Void){
        getUserSingleWorkoutDocumentId(uid: uid, wId: wId) { (userDoc, workoutDoc) in
            fireStoreDatabase
                .collection(Constants.DataBaseFireStoreConstants.usersCollectionInDatabase)
                .document(userDoc)
                .collection(Constants.DataBaseFireStoreConstants.workoutsCollectionInDataBase)
                .document(workoutDoc)
                .setData([Constants.DataBaseFireStoreConstants.exercisesInDatabase:exercises], merge: true)
            
            if let title = title{
                addAndMergeWorkoutTitle(uid: uid, wId: wId, title: title)
            }
            DispatchQueue.main.async {
                done(true)
            }
        }
    }
    
    /**
     This method
     Merges the title of the workout with the new one gotten
     */
    static func addAndMergeWorkoutTitle(uid:String,wId:String,title:String){
        getUserSingleWorkoutDocumentId(uid: uid, wId: wId) { (userDoc, workoutDoc) in
            fireStoreDatabase
                .collection(Constants.DataBaseFireStoreConstants.usersCollectionInDatabase)
                .document(userDoc)
                .collection(Constants.DataBaseFireStoreConstants.workoutsCollectionInDataBase)
                .document(workoutDoc).setData(
                    [Constants.DataBaseFireStoreConstants.titleInDataBase:title],
                    merge: true)
        }
    }
    
    
    /**
     This metod
     Changes the title of a workout document  with given uid and date
     */
    static func addAndMergeWorkoutTitle(uid:String,wId:String,newTitle:String){
        getUserSingleWorkoutDocumentId(uid: uid, wId: wId) { (userDoc, workoutDoc) in
            fireStoreDatabase
                .collection(Constants.DataBaseFireStoreConstants.usersCollectionInDatabase)
                .document(userDoc)
                .collection(Constants.DataBaseFireStoreConstants.workoutsCollectionInDataBase)
                .document(workoutDoc)
                .setData([Constants.DataBaseFireStoreConstants.titleInDataBase:newTitle], merge: true)
        }
    }
    
    /**
     This method
     Deletes a workout document with given uid and date
     */
    static func deleteWorkoutDocument(uid:String,wId:String){
        getUserSingleWorkoutDocumentId(uid: uid, wId: wId) { (userDoc, workoutDoc) in
            fireStoreDatabase
                .collection(Constants.DataBaseFireStoreConstants.usersCollectionInDatabase)
                .document(userDoc)
                .collection(Constants.DataBaseFireStoreConstants.workoutsCollectionInDataBase)
                .document(workoutDoc).delete()
        }
    }
    
    
    
}

