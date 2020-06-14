//
//  SingleRecepieViewController.swift
//  IronLogs
//
//  Created by Meron Skop on 12/06/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class SingleRecepieViewController: UIViewController {

    var currentDayOfEating:DayOfEating?
    var recepie:APIFoodItem?
    var url:String?
    
    let mViewModel = SingleRecepieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SpoonacularDataSource.getRecepiePage(id: recepie!.id) { [weak self] (url, err) in
            guard let url = url?.sourceUrl else{
                return
            }
            self?.url = url
        }
    }
    
    //Find a way to view the image here
    @IBOutlet weak var fooImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var fats: UILabel!
    
    
    //Find a way to send the user to the recepie
    @IBAction func goToRecepieWebsite(_ sender: UIButton) {
    }
    
    
    //MARK: convert the recepie into a foodItem in the viewModel
    @IBAction func addMeal(_ sender: Any) {
        guard let currentDayOfEating = currentDayOfEating else{
            return
        }
        guard let recepie = recepie else {
            return
        }
        mViewModel.addMeal(mealToAdd: recepie, currentDayOfEating: currentDayOfEating)
        showSuccsess(title: "Added")
    }
}
