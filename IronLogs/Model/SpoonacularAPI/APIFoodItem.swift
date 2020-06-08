//
//  APIRecipe.swift
//  IronLogs
//
//  Created by Meron Skop on 25/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation



struct APIFoodItem:Decodable{
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
}





