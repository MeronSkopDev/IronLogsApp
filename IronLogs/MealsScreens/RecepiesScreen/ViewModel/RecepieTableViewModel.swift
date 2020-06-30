//
//  RecepieTableViewModel.swift
//  IronLogs
//
//  Created by Meron Skop on 08/06/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

struct RecepieTableViewModel:ShowHud{
    
    func getRecepies(querys:[String:String], callBack:@escaping ([APIFoodItem]?) -> Void){
        SpoonacularDataSource.getRecepies(searchParams: querys) { (foodItems, err) in
            if err != nil{
                self.showError(title: "Couldent get recepies")
            } else{
                callBack(foodItems)
            }
        }
    }
    
}
