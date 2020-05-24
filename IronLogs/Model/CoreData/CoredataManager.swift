//
//  CoredataManager.swift
//  IronLogs
//
//  Created by Meron Skop on 18/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation
import CoreData

class CM{
    
    static let shared = CM()
    
    private init(){}
    
    var context:NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    /**
     This method
     Returns all the "DayOfEating" objects
     */
    func getDaysOfEating() -> [DayOfEating]{
        let request = NSFetchRequest<DayOfEating>(entityName: "DayOfEating")
        do{
            let daysOfEating = try context.fetch(request)
            return daysOfEating
        }catch let err{
            print("------ Couldent get daysOfEating -----")
            print(err.localizedDescription)
            return[]
        }
    }
    
    /**
     This lazy var
     A pre made method by Xcode
     Returns the "container" that has all the saved data in it
     */
    lazy var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "IronLogs")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {
                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()

    /**
     This method
     Saves all changes done to the objects from the container
     */
       func saveContext () {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }
}
