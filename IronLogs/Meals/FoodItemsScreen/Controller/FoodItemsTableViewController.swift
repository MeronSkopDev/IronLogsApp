//
//  FoodItemsTableViewController.swift
//  IronLogs
//
//  Created by Meron Skop on 19/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class FoodItemsTableViewController: UITableViewController {
    
    var fatherDayOfEating:DayOfEating?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dayOfeatingTitleNib = UINib(nibName: "DayOfEatingTitleTableViewCell", bundle: .main)
        tableView.register(dayOfeatingTitleNib, forCellReuseIdentifier: "dayOfEatingTitleCell")
        
        let macrosNib = UINib(nibName: "MacrosTableViewCell", bundle: .main)
        tableView.register(macrosNib, forCellReuseIdentifier: "macrosCell")
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayOfEatingTitleCell", for: indexPath) as! DayOfEatingTitleTableViewCell
        cell.populateCell(title:fatherDayOfEating?.title)
            
        if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "macrosCell", for: indexPath) as! MacrosTableViewCell
            cell.populateCell(dayOfEating: fatherDayOfEating)
            return cell
        }
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
