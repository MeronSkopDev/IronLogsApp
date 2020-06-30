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
    
    var currentDayOfEating:DayOfEating?
    var recepie:APIFoodItem?
    var url:String?
    
    let mViewModel = SingleRecepieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadImage()
        loadUI()
        drawfatsCircle()
        drawCarbsCircle()
        drawProteinCircle()
    }
    
    func loadImage(){
        guard let recepieImage = recepie?.image else{
            return
        }
        foodImage.sd_setImage(with: URL(string: recepieImage))
    }
    
    func loadUI(){
        caloriesLabel.text = "Cal: \(recepie?.calories ?? 0)"
        proteinLabel.text = "\(recepie?.protein.dropLast() ?? "0")"
        carbsLabel.text = "\(recepie?.carbs.dropLast() ?? "0")"
        fatsLabel.text = "\(recepie?.fat.dropLast() ?? "0")"
    }
    
    
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
    
    //MARK: Tidy this up. Move the whole circle drawing part to a utility class
    
    func getTotalMacros() -> Int{
        let protein = Int(recepie?.protein.dropLast() ?? "0") ?? 0
        let carbs = Int(recepie?.carbs.dropLast() ?? "0") ?? 0
        let fats = Int(recepie?.fat.dropLast() ?? "0") ?? 0
        
        return protein + carbs + fats
    }
    
    func getPartInFraction(partToFind: Int16) -> Float{
        return Float(partToFind)/Float(getTotalMacros())
    }
    
    func drawProteinCircle(){
        let lineLayer = CAShapeLayer()
        
        let centerX = proteinStack.center.x + 16
        let centerY = proteinStack.center.y + 400
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        lineLayer.fillColor = nil
        
        lineLayer.path = circlePath.cgPath
        lineLayer.strokeColor = UIColor.red.cgColor
        lineLayer.lineWidth = 5
        
        lineLayer.strokeEnd = 0
        
        lineLayer
            .add(getAnimationForCircle(partToFill:getPartInFraction(partToFind: Int16(recepie?.protein.dropLast() ?? "1") ?? 1)), forKey: "protein")
        
        let trackLayer = CAShapeLayer()
        
        trackLayer.path = circlePath.cgPath
        
        trackLayer.fillColor = nil
        
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.lineCap = .round
        
        view.layer.addSublayer(trackLayer)
        
        view.layer.addSublayer(lineLayer)
    }
    
    func drawCarbsCircle(){
        let lineLayer = CAShapeLayer()
        
        let centerX = carbsStack.center.x + 16
        let centerY = carbsStack.center.y + 400
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        lineLayer.fillColor = nil
        
        lineLayer.path = circlePath.cgPath
        lineLayer.strokeColor = UIColor.blue.cgColor
        lineLayer.lineWidth = 5
        
        lineLayer.strokeEnd = 0
        
        lineLayer
            .add(getAnimationForCircle(partToFill: getPartInFraction(partToFind: Int16(recepie?.carbs.dropLast() ?? "1") ?? 1)), forKey: "carbs")
        
        let trackLayer = CAShapeLayer()
        
        trackLayer.path = circlePath.cgPath
        
        trackLayer.fillColor = nil
        
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.lineCap = .round
        
        view.layer.addSublayer(trackLayer)
        
        view.layer.addSublayer(lineLayer)
    }
    
    func drawfatsCircle(){
        let lineLayer = CAShapeLayer()
        
        let centerX = fatsStack.center.x + 15
        let centerY = fatsStack.center.y + 400
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        lineLayer.fillColor = nil
        
        lineLayer.strokeEnd = 0
        
        lineLayer.path = circlePath.cgPath
        lineLayer.strokeColor = UIColor.systemYellow.cgColor
        lineLayer.lineWidth = 5
        
        lineLayer.lineCap = .round
        
        lineLayer
            .add(getAnimationForCircle(partToFill: getPartInFraction(partToFind: Int16(recepie?.fat.dropLast() ?? "1") ?? 1)), forKey: "fats")
        
        let trackLayer = CAShapeLayer()
        
        trackLayer.path = circlePath.cgPath
        
        trackLayer.fillColor = nil
        
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.lineCap = .round
        
        view.layer.addSublayer(trackLayer)
        
        view.layer.addSublayer(lineLayer)
    }
    
    func getAnimationForCircle(partToFill:Float) -> CABasicAnimation{
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = partToFill
        
        basicAnimation.duration = 2
        
        //This will make sure that after the stroke is drawn it is not removed
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        return basicAnimation
    }
}
