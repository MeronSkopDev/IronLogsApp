//
//  SpoonacularManager.swift
//  IronLogs
//
//  Created by Meron Skop on 23/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation
import PKHUD

//https://api.spoonacular.com/recipes/findByNutrients?apiKey=0e113c7f72ff49b7bb23076e971198da&minProtein=10&maxProtein=100&minCalories=10&maxCalories=100&minCarbs=10&maxCarbs=100&minFats=10&maxFats=100&number=100


class SpoonacularDataSource:ShowHud{
    
    
    
    static func getRecepies(searchParams:[String:String],cacheString:String, callBack: @escaping ([APIFoodItem]?,Error?) -> Void){
        var baseURL:String = "https://api.spoonacular.com/recipes/findByNutrients?apiKey=0e113c7f72ff49b7bb23076e971198da"
        
        for (key,value) in searchParams{
            baseURL.append("&\(key)=\(value)")
        }
        
        baseURL.append("&number=99")
        
        if let cached = SpoonacularCache.getCached(cacheString: cacheString){
            if (cached.isEmpty){
                
            }else{
                callBack(cached,nil)
                return
            }
        }
        
        guard let url = URL(string: baseURL)else{
            HUD.show(.labeledError(title: "Couldent get recepies", subtitle: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url){(data, response, err) in
            
            guard let data = data else{
                HUD.show(.labeledError(title: "Couldent get recepies", subtitle: nil))
                callBack(nil,err)
                return
            }
            
            let decoder = JSONDecoder()
            
            do{
                let APIResults = try decoder.decode([APIFoodItem].self, from: data)
                DispatchQueue.main.sync {
                    SpoonacularCache.cache(cacheString: cacheString, toCache: APIResults)
//                    print("BASE")
//                    print(baseURL)
//                    print("BASE")
                    callBack(APIResults,nil)
                }
            }catch let error{
                HUD.show(.labeledError(title: "Couldent get recepies", subtitle: nil))
                callBack(nil,error)
            }
            
        }.resume()
        
    }
    
    static func getRecepiePage(id:Int,callBack: @escaping (RecepieUrl?,Error?) -> Void){
        //https://api.spoonacular.com/recipes/{Insert ID}/information?apiKey=0e113c7f72ff49b7bb23076e971198da
        
        let baseURL = "https://api.spoonacular.com/recipes/\(id)/information?apiKey=0e113c7f72ff49b7bb23076e971198da"
        
        guard let url = URL(string: baseURL) else{
        return
        }
        
        URLSession.shared.dataTask(with: url){(data, res, err) in
            
            guard let data = data else{
                //MARK: Handle error
                callBack(nil,err)
                print("*** Couldent get the data FOR URL ***")
                return
            }
            
            let decoder = JSONDecoder()
            
            do{
                let results = try decoder.decode(RecepieUrl.self, from: data)
                DispatchQueue.main.async {
                    callBack(results,nil)
                }
            }catch let e{
                print("&&& Couldent decode DATA FOR URL &&&")
                DispatchQueue.main.async {
                    callBack(nil,e)
                }
            }
        }.resume()
        
        
    }
        
        
    
}
