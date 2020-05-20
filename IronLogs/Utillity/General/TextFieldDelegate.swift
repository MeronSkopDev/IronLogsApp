//
//  TextFieldDelegate.swift
//  IronLogs
//
//  Created by Meron Skop on 17/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

protocol editTextObserversDelegate:class {
    func getTextOnChange(text:String)
}

protocol WeightAndRepsObservationDelegate:class {
    func getWeightOnChange(weight:Int, currentSetIndex: Int)
    func getRepsOnChange(reps:Int, currentSetIndex: Int)
}

protocol SuperSetDelegate:class{
    func getCurrentWeightOnChange(weight:Int, currentSetIndex: Int)
    func getCurrentRepsOnChange(reps:Int, currentSetIndex: Int)
    func getSuperWeightOnChange(weight:Int, currentSetIndex: Int)
    func getSuperRepsOnChange(reps:Int, currentSetIndex: Int)
    func getSuperNameOnChange(text:String, currentSetIndex: Int)
}
