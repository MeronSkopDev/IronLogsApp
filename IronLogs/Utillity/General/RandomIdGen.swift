//
//  RandomIdGen.swift
//  IronLogs
//
//  Created by Meron Skop on 17/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

struct RandomIdGen {
    /**
     This method
     Returns a random id
     */
    static func generateId() -> String{
        let newID = UUID()
        return newID.uuidString
    }
}
