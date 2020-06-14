//
//  SingleRecepieViewController.swift
//  IronLogs
//
//  Created by Meron Skop on 12/06/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit
import SDWebImage

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
        
        loadImage()
    }
    
    func loadImage(){
        guard let recepieImage = recepie?.image else{
            return
        }
        fooImage.sd_setImage(with: URL(string: recepieImage))
    }
    
    @IBOutlet weak var fooImage: UIImageView!
    
    @IBAction func goToRecepieWebsite(_ sender: UIButton) {
        guard let url = url else{
            return
        }
        if let urlCon = URL(string: url){
            UIApplication.shared.open(urlCon)
        }
    }
    
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
