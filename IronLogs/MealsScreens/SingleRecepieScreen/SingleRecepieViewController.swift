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
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var carbsLabel: UILabel!
    
    @IBOutlet weak var fatsLabel: UILabel!
    
    @IBOutlet weak var proteinStack: UIStackView!
    
    @IBOutlet weak var carbsStack: UIStackView!
    
    @IBOutlet weak var fatsStack: UIStackView!
    
    @IBOutlet weak var prosStack: UIStackView!
    
    @IBOutlet weak var consStack: UIStackView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    @IBOutlet weak var toRecepieButton: UIButton!
    @IBOutlet weak var addMealButton: UIButton!
    
    var currentDayOfEating:DayOfEating?
    var recepie:APIFoodItem?
    var url:String?
    
    var consAndProsLoaded = false
    
    let mViewModel = SingleRecepieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadImage()
        loadUI()
        choosePic()
        styleButtons()
        
        ///Protein circle
        DrawCircle.drawCircleForMacros(fillAmount:
            DrawCircle.getPartInFraction(partToFind:
                Int16(recepie?.protein.dropLast() ?? "0") ?? 1, total:
                getTotalMacros()),
                                       color: UIColor.red.cgColor,
                                       centerX: proteinStack.center.x + 16,
                                       centerY: proteinStack.center.y + 410,
                                       drawOn: view.layer)
        
        ///Carbs circle
        DrawCircle.drawCircleForMacros(fillAmount:
            DrawCircle.getPartInFraction(partToFind:
                Int16(recepie?.carbs.dropLast() ?? "0") ?? 1, total:
                getTotalMacros()),
                                       color: UIColor.systemBlue.cgColor,
                                       centerX: carbsStack.center.x + 16,
                                       centerY: carbsStack.center.y + 410,
                                       drawOn: view.layer)
        ///Fats circle
        DrawCircle.drawCircleForMacros(fillAmount:
            DrawCircle.getPartInFraction(partToFind:
                Int16(recepie?.fat.dropLast() ?? "0") ?? 1, total:
                getTotalMacros()),
                                       color: UIColor.systemYellow.cgColor,
                                       centerX: fatsStack.center.x + 15,
                                       centerY: fatsStack.center.y + 410,
                                       drawOn: view.layer)
    }
    
    func loadImage(){
        guard let recepieImage = recepie?.image else{
            return
        }
        if let image = SDImageCache.shared.imageFromCache(forKey: recepieImage){
            foodImage.image = image
            foodImage.layer.cornerRadius = 8.0
            foodImage.clipsToBounds = true
        }else{
            foodImage.sd_setImage(with: URL(string: recepieImage))
            foodImage.layer.cornerRadius = 8.0
            foodImage.clipsToBounds = true
            SDImageCache.shared.store(foodImage.image, forKey: recepieImage) {
            }
        }
    }
    
    func loadUI(){
        caloriesLabel.text = "Cal: \(recepie?.calories ?? 0)"
        proteinLabel.text = "\(recepie?.protein.dropLast() ?? "0")"
        carbsLabel.text = "\(recepie?.carbs.dropLast() ?? "0")"
        fatsLabel.text = "\(recepie?.fat.dropLast() ?? "0")"
        if(!consAndProsLoaded){
            addPros()
            addCons()
            consAndProsLoaded = !consAndProsLoaded
        }
    }
    
    
    @IBAction func goToRecepieWebsite(_ sender: UIButton) {
        guard let id = recepie?.id else {
            return
        }
        SpoonacularDataSource.getRecepiePage(id: id) { (recepieUrl, err) in
            if let _ = err {
                self.showError(title: "Couldent connect")
            }else{
                guard let url = recepieUrl?.sourceUrl else{
                    self.showError(title: "Couldent connect")
                    return
                }
                if let urlCon = URL(string: url){
                    UIApplication.shared.open(urlCon)
                }
            }
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
    
    func getTotalMacros() -> Int{
        let protein = Int(recepie?.protein.dropLast() ?? "0") ?? 0
        let carbs = Int(recepie?.carbs.dropLast() ?? "0") ?? 0
        let fats = Int(recepie?.fat.dropLast() ?? "0") ?? 0
        
        return protein + carbs + fats
    }
    
    func addPros(){
        if(Int(recepie!.protein.dropLast()) ?? 0 >= 30){
            mViewModel.addLabel(content: "High in protein", stack: prosStack, view: view)
        }
        if(Int(recepie!.fat.dropLast()) ?? 0 <= 10){
            mViewModel.addLabel(content: "Low in fats", stack: prosStack, view: view)
        }
        if(Int(recepie!.carbs.dropLast()) ?? 0 < 20){
            mViewModel.addLabel(content: "Low in carbs", stack: prosStack, view: view)
        }
    }
    
    func addCons(){
        if(Int(recepie!.protein.dropLast()) ?? 0 <= 10){
            mViewModel.addLabel(content: "Low in protein", stack: consStack, view: view)
        }
        if(Int(recepie!.fat.dropLast()) ?? 0 > 20){
            mViewModel.addLabel(content: "High in fats", stack: consStack, view: view)
        }
        if(Int(recepie!.carbs.dropLast()) ?? 0 > 40){
            mViewModel.addLabel(content: "High in carbs", stack: consStack, view: view)
        }
    }
    
    func choosePic(){
        let imageNum = Int.random(in: 1...4)
        backgroundImage.image = UIImage(named: "tableTop\(imageNum)")
        backgroundImage.alpha = 0.8
    }
    
    func styleButtons(){
        toRecepieButton.layer.cornerRadius = 15.0
        toRecepieButton.clipsToBounds = true
        toRecepieButton.setTitleColor(UIColor.lightGray, for: .selected)
        
        addMealButton.layer.cornerRadius = 15.0
        addMealButton.clipsToBounds = true
        addMealButton.setTitleColor(UIColor.lightGray, for: .selected)
    }
    
}
