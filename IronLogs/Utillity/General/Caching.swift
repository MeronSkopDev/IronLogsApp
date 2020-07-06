//
//  Caching.swift
//  IronLogs
//
//  Created by Meron Skop on 06/07/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

struct SpoonacularCache{
    
    static let cache = NSCache<NSString, APIFoodItemHolder>()
    
    static func cache(cacheString: String, toCache: [APIFoodItem]){
        let cacheString = NSString(string: cacheString)
        
        let readyToCache = APIFoodItemHolder(foodItems: toCache)
        cache.setObject(readyToCache, forKey: cacheString)
        print("------ cached ------")
    }
    
    
    static func getCached(cacheString: String) -> [APIFoodItem]?{
        let cacheString = NSString(string: cacheString)
        
        if let cached = cache.object(forKey: cacheString){
            print("****** Gotten from cache ******")
            return cached.foodItems
        }
        print(cache.object(forKey: cacheString)?.foodItems)
        print("&&&&&& Was not in cache &&&&&&")
        return []
    }
    
}
