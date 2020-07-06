//
//  FoodItemsTableViewController.swift
//  IronLogs
//
//  Created by Meron Skop on 19/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class FoodItemsTableViewController: UITableViewController {
    
    var currentDayOfEating:DayOfEating?
    let mViewModel = FoodItemsTableViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dayOfeatingTitleNib = UINib(nibName: "DayOfEatingTitleTableViewCell", bundle: .main)
        tableView.register(dayOfeatingTitleNib, forCellReuseIdentifier: "dayOfEatingTitleCell")
        
        let macrosNib = UINib(nibName: "MacrosTableViewCell", bundle: .main)
        tableView.register(macrosNib, forCellReuseIdentifier: "macrosCell")
        
        let foodItemNib = UINib(nibName: "FoodItemTableViewCell", bundle: .main)
        tableView.register(foodItemNib, forCellReuseIdentifier: "foodItemCell")
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + (currentDayOfEating?.foodItemsInside.value.count ?? 0)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayOfEatingTitleCell", for: indexPath) as! DayOfEatingTitleTableViewCell
        if currentDayOfEating != nil{
            cell.populateCell(dayOfEating: currentDayOfEating!)
            cell.initObserver()
        }
        
        //For the second cell we show the "macrosCell"
        if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "macrosCell", for: indexPath) as! MacrosTableViewCell
            cell.populateCell(dayOfEating: currentDayOfEating)
            //MARK: Update this cell when the user changes the "FoodIten" cell values
            return cell
        }
        
        //All cells greater then the third will show "FoodItem"
        if indexPath.row >= 2{
            guard let currentFoodItem = currentDayOfEating?.foodItemsInside.value[indexPath.row - 2] else{
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodItemCell") as! FoodItemTableViewCell
            cell.initObservers()
            cell.populateCell(foodItem: currentFoodItem)
            return cell
        }
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 1 || indexPath.row == 0{
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let currentFoodItem = currentDayOfEating?.foodItemsInside.value[indexPath.row - 2] else{
                return
            }
            tableView.beginUpdates()
            currentDayOfEating?.removeFromFoodItem(currentFoodItem)
            CM.shared.saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            tableView.reloadData()
            
        }
    }
    
    
    /**
     This method
     Adds a new "FoodItem" to the database
     Reloads the tableVeiw
     */
    @IBAction func addFoodItem(_ sender: UIBarButtonItem) {
        //MARK: Check why sometimes it adds the new row with the parameter of the existing one
        mViewModel.addNewFoodItem(dayOfEating: currentDayOfEating)
        tableView.reloadData()
    }
    
    /**
     This method
     Moves to "RecepiesTableViewController"
     */
    @IBAction func goToAPI(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toAPIFoods", sender: currentDayOfEating)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? RecepieTableViewController else{
            return
        }
        guard let currentDayOfEating = sender as? DayOfEating else{
            return
        }
        dest.currentDayOfEating = currentDayOfEating
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
