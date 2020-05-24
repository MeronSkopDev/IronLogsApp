//
//  DaysOfEatingTableViewController.swift
//  IronLogs
//
//  Created by Meron Skop on 18/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

import CoreData

class DaysOfEatingTableViewController: UITableViewController {
    
    let mViewModel = DayOfEatingTableViewModel()
    
    lazy var fetch:NSFetchedResultsController<DayOfEating> = {
        let request = NSFetchRequest<DayOfEating>(entityName: "DayOfEating")
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "dateOfCreation", ascending: true)
        ]
        
        let context = CM.shared.context
        
        let fetchController = NSFetchedResultsController(fetchRequest: request,
                                                         managedObjectContext: context,
                                                         sectionNameKeyPath: nil,
                                                         cacheName: "DaysOfEating")
        return fetchController
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch.delegate = self
        do{
            try fetch.performFetch()
        }catch let err{
            print("****** Could not do the FETCH ******")
            print(err.localizedDescription)
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetch.sections?[section].numberOfObjects ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayOfEatingCell", for: indexPath)
        
        if let cell = cell as? DayOfEatingTableViewCell{
            let dayOfEating = fetch.object(at: indexPath)
            cell.populateCell(dayOfEating: dayOfEating)
        }
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dayToDelete = fetch.object(at: indexPath)
            
            CM.shared.context.delete(dayToDelete)
            
            CM.shared.saveContext()
        }
    }
    
    /**
     This method
     Moves to HomeViewController
     */
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        let homeStoryboard = UIStoryboard(name: "Home", bundle: .main)
        Router.shared.window?.rootViewController = homeStoryboard.instantiateInitialViewController()
    }
    
    /**
     This method
     Adds a new "DayOfEating" to the database
     */
    @IBAction func addDayOfEating(_ sender: UIBarButtonItem) {
        mViewModel.createNewDayOfEating()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toFoodItems", sender: fetch.object(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? FoodItemsTableViewController{
            let dayOfEating = sender as! DayOfEating
            dest.currentDayOfEating = dayOfEating
        }
    }
    
    
}


extension DaysOfEatingTableViewController:NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            break
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
            break
        default:
            break
        }
    }
}
