//
//  APIRecipe.swift
//  IronLogs
//
//  Created by Meron Skop on 25/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation



struct APIFoodItem:Codable{
    let id:Int
    let title:String
    let image:String
    let calories:Int
    let protein:String
    let fat:String
    let carbs:String
    
    enum CodingKeys:String,CodingKey{
        case id,title,image,calories,protein,fat,carbs
    }
    
    init(from decoder:Decoder) throws{
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        
        do{
            id = try container.decode(Int.self , forKey: .id)
        }catch {
            id = 999
        }
        do{
            title = try container.decode(String.self , forKey: .title)
        }catch {
            title = "No title"
        }
        do{
            image = try container.decode(String.self , forKey: .image)
        }catch {
            image = "No image"
        }
        do{
            calories = try container.decode(Int.self , forKey: .calories)
        }catch {
            calories = 999
        }
        do{
            protein = try container.decode(String.self , forKey: .protein)
        }catch {
            protein = "No protein"
        }
        do{
            fat = try container.decode(String.self , forKey: .fat)
        }catch {
            fat = "No fat"
        }
        do{
            carbs = try container.decode(String.self , forKey: .carbs)
        }catch {
            carbs = "No carbs"
        }
    }
    
    func encode(to encoder:Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(image, forKey: .image)
        try container.encode(calories, forKey: .calories)
        try container.encode(protein, forKey: .protein)
        try container.encode(fat, forKey: .fat)
        try container.encode(carbs, forKey: .carbs)
    }
}


class APIFoodItemHolder{
    var foodItems:[APIFoodItem]!
    
    init(foodItems:[APIFoodItem]){
        self.foodItems = foodItems
    }
}




