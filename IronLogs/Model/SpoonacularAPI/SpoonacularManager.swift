//
//  SpoonacularManager.swift
//  IronLogs
//
//  Created by Meron Skop on 23/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

//https://api.spoonacular.com/recipes/findByNutrients?apiKey=0e113c7f72ff49b7bb23076e971198da&minProtein=10&maxProtein=100&minCalories=10&maxCalories=100&minCarbs=10&maxCarbs=100&minFats=10&maxFats=100&number=100

//MARK: get the data of the recepies
//Make methods to query recepies by calories, protein, carbs, fats


class SpoonacularDataSource{
    
    
    static func getRecepies(searchParams:[String:String], callBack: @escaping ([APIFoodItem]?,Error?) -> Void){
        var baseURL:String = "https://api.spoonacular.com/recipes/findByNutrients?apiKey=0e113c7f72ff49b7bb23076e971198da"
        
        for (key,value) in searchParams{
            baseURL.append("&\(key)=\(value)")
        }
        
        baseURL.append("&number=2")
        
        guard let url = URL(string: baseURL)else{
            //MARK: Handle error
            print("--- Couldent open URL ---")
            return
        }
        
        URLSession.shared.dataTask(with: url){(data, response, err) in
            
            guard let data = data else{
                //MARK: Handle error
                callBack(nil,err)
                print("*** Couldent get the data ***")
                return
            }
            
            let decoder = JSONDecoder()
            
            do{
                let APIResults = try decoder.decode([APIFoodItem].self, from: data)
                DispatchQueue.main.sync {
                    callBack(APIResults,nil)
                }
            }catch let error{
                //MARK: Handle error
                print("&&& Couldent decode DATA &&&")
                callBack(nil,error)
            }
            
        }.resume()
        
    }
    
    
}
