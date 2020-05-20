//
//  SetsTableView+Extention.swift
//  IronLogs
//
//  Created by Meron Skop on 18/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

///This extention is to delegate changes in RegularSet cells
extension SetsTableViewController:WeightAndRepsObservationDelegate{
    /**
     This method
     Updates the weight in " WorkoutsInUse.shared()" in the exercise the user is currently looking at
     */
    func getWeightOnChange(weight: Int, currentSetIndex: Int) {
        if workoutsIndex != nil{
            if exercisesIndex != nil{
                if isCurrentlyDeleating{
                    WorkoutsInUse.shared()
                        .workouts
                        .value[workoutsIndex!]
                        .exercises?[exercisesIndex!]
                        .sets?[currentSetIndex - 1].weight = weight
                    
                    
                    isCurrentlyDeleating = false
                }else{
                    if workoutsIndex != nil{
                        if exercisesIndex != nil{
                            WorkoutsInUse.shared()
                                .workouts
                                .value[workoutsIndex!]
                                .exercises?[exercisesIndex!]
                                .sets?[currentSetIndex].weight = weight
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    
    /**
     This method
     Updates the reps in " WorkoutsInUse.shared()" in the exercise the user is currently looking at
     */
    func getRepsOnChange(reps: Int, currentSetIndex: Int) {
        
        if workoutsIndex != nil{
            if exercisesIndex != nil{
                if isCurrentlyDeleating{
                    WorkoutsInUse.shared()
                        .workouts
                        .value[workoutsIndex!]
                        .exercises?[exercisesIndex!]
                        .sets?[currentSetIndex - 1].reps = reps
                    
                    
                    isCurrentlyDeleating = false
                }else{
                    if workoutsIndex != nil{
                        if exercisesIndex != nil{
                            WorkoutsInUse.shared()
                                .workouts
                                .value[workoutsIndex!]
                                .exercises?[exercisesIndex!]
                                .sets?[currentSetIndex].reps = reps
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    
}

///This extention is to delegate changes in SuperSet cells
extension SetsTableViewController:SuperSetDelegate{
    
    /**
     This method
     Updates the weight in " WorkoutsInUse.shared()" in the exercise the user is currently looking at
     */
    func getCurrentWeightOnChange(weight: Int, currentSetIndex: Int) {
        
        if workoutsIndex != nil{
            if exercisesIndex != nil{
                if isCurrentlyDeleating{
                    WorkoutsInUse.shared()
                        .workouts
                        .value[workoutsIndex!]
                        .exercises?[exercisesIndex!]
                        .sets?[currentSetIndex - 1].weight = weight
                    
                    
                    isCurrentlyDeleating = false
                }else{
                    if workoutsIndex != nil{
                        if exercisesIndex != nil{
                            WorkoutsInUse.shared()
                                .workouts
                                .value[workoutsIndex!]
                                .exercises?[exercisesIndex!]
                                .sets?[currentSetIndex].weight = weight
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    /**
     This method
     Updates the reps in " WorkoutsInUse.shared()" in the exercise the user is currently looking at
     */
    func getCurrentRepsOnChange(reps: Int, currentSetIndex: Int) {
        
        if workoutsIndex != nil{
            if exercisesIndex != nil{
                if isCurrentlyDeleating{
                    WorkoutsInUse.shared()
                        .workouts
                        .value[workoutsIndex!]
                        .exercises?[exercisesIndex!]
                        .sets?[currentSetIndex - 1].reps = reps
                    
                    
                    isCurrentlyDeleating = false
                }else{
                    if workoutsIndex != nil{
                        if exercisesIndex != nil{
                            WorkoutsInUse.shared()
                                .workouts
                                .value[workoutsIndex!]
                                .exercises?[exercisesIndex!]
                                .sets?[currentSetIndex].reps = reps
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    /**
     This method
     Updates the superWeight in " WorkoutsInUse.shared()" in the exercise the user is currently looking at
     */
    func getSuperWeightOnChange(weight: Int, currentSetIndex: Int) {
        
        if workoutsIndex != nil{
            if exercisesIndex != nil{
                if isCurrentlyDeleating{
                    WorkoutsInUse.shared()
                        .workouts
                        .value[workoutsIndex!]
                        .exercises?[exercisesIndex!]
                        .sets?[currentSetIndex - 1].superWeight = weight
                    
                    
                    isCurrentlyDeleating = false
                }else{
                    if workoutsIndex != nil{
                        if exercisesIndex != nil{
                            WorkoutsInUse.shared()
                                .workouts
                                .value[workoutsIndex!]
                                .exercises?[exercisesIndex!]
                                .sets?[currentSetIndex].superWeight = weight
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    /**
     This method
     Updates the superReps in " WorkoutsInUse.shared()" in the exercise the user is currently looking at
     */
    func getSuperRepsOnChange(reps: Int, currentSetIndex: Int) {
        
        if workoutsIndex != nil{
            if exercisesIndex != nil{
                if isCurrentlyDeleating{
                    WorkoutsInUse.shared()
                        .workouts
                        .value[workoutsIndex!]
                        .exercises?[exercisesIndex!]
                        .sets?[currentSetIndex - 1].superReps = reps
                    
                    
                    isCurrentlyDeleating = false
                }else{
                    if workoutsIndex != nil{
                        if exercisesIndex != nil{
                            WorkoutsInUse.shared()
                                .workouts
                                .value[workoutsIndex!]
                                .exercises?[exercisesIndex!]
                                .sets?[currentSetIndex].superReps = reps
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    /**
     This method
     Updates the superName in " WorkoutsInUse.shared()" in the exercise the user is currently looking at
     */
    func getSuperNameOnChange(text: String, currentSetIndex: Int) {
        
        if workoutsIndex != nil{
            if exercisesIndex != nil{
                if isCurrentlyDeleating{
                    WorkoutsInUse.shared()
                        .workouts
                        .value[workoutsIndex!]
                        .exercises?[exercisesIndex!]
                        .sets?[currentSetIndex - 1].superName = text
                    
                    
                    isCurrentlyDeleating = false
                }else{
                    if workoutsIndex != nil{
                        if exercisesIndex != nil{
                            WorkoutsInUse.shared()
                                .workouts
                                .value[workoutsIndex!]
                                .exercises?[exercisesIndex!]
                                .sets?[currentSetIndex].superName = text
                            
                        }
                    }
                }
            }
        }
    }
}
