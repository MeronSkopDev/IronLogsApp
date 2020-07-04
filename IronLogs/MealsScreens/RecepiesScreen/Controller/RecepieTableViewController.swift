//
//  RecepieTableViewController.swift
//  IronLogs
//
//  Created by Meron Skop on 25/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

//MARK: Add cahching!

class RecepieTableViewController: UITableViewController {

    var currentDayOfEating:DayOfEating?
    var recepies:[APIFoodItem] = []
    
    let mViewModel = RecepieTableViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        let recepieNib = UINib(nibName: "RecepieTableViewCell", bundle: .main)
        tableView.register(recepieNib, forCellReuseIdentifier: "recepieCell")
        
        let searchNib = UINib(nibName: "SearchTableViewCell", bundle: .main)
        tableView.register(searchNib, forCellReuseIdentifier: "searchCell")
    }

   
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1 + recepies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell",for: indexPath) as! SearchTableViewCell
        
        cell.queryDelegate = self
        
        if indexPath.row >= 1{
        let cell = tableView.dequeueReusableCell(withIdentifier: "recepieCell", for: indexPath)  as! RecepieTableViewCell
            
        
            cell.populateCell(recepie: recepies[indexPath.row - 1])
            return cell
        }
        
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(recepies.count > 0){
        performSegue(withIdentifier: "toRecepie", sender: recepies[indexPath.row - 1])
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recepie = sender as? APIFoodItem else{
            return
        }
        guard let dest = segue.destination as? SingleRecepieViewController else{
            return
        }
        dest.recepie = recepie
        dest.currentDayOfEating = currentDayOfEating
    }
    
}

extension RecepieTableViewController:ApiFoodItemsQuerysDelegate{
    func getFoodItems(querys: [String : String]) {
        showProgress()
        mViewModel.getRecepies(querys: querys) {[weak self] (recepies) in
            self?.recepies = recepies ?? []
            if(recepies!.count == 0){
                self?.showError(title: "No results")
            }else{
            self?.tableView.reloadData()
            self?.showSuccsess()
            }
        }
    }


}
