//
//  HomeViewController.swift
//  IronLogs
//
//  Created by Meron Skop on 16/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

//MARK: Add a place that the user can take images of himslef and see progress

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var workoutImage: UIImageView!
    
    @IBOutlet weak var barbellIcon: UIImageView!
    
    @IBOutlet weak var hamburgerIcon: UIImageView!
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var rightArmImage: UIImageView!
    
    @IBOutlet weak var leftArmImage: UIImageView!
    
    var direction = "None"
    
    override func viewDidAppear(_ animated: Bool) {
        assignUserNameToLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panRecognizer = UIPanGestureRecognizer(target: self, action:  #selector(panedView))
        self.view.addGestureRecognizer(panRecognizer)
    }
    
    /**
     This method
     Signs user out of Firebase
     */
    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            Router.shared.chooseScreen(ifLogeedInGoTo: "Home")
        }catch let err{
            showError(title: err.localizedDescription)
        }
    }
    
    /**
     This method
     Gets the user's display name from the database
     Puts the users display name as "userNameLabel" text
     */
    func assignUserNameToLabel(){
        FSData.getUserNickName(uid: Auth.auth().currentUser?.uid ?? "") { (nickName) in
            self.userNameLabel.text = nickName
            self.rightArmImage.alpha = 1
            self.leftArmImage.alpha = 1
        }
        
    }
    
    @objc func panedView(sender:UIPanGestureRecognizer){
        var startLocation = CGPoint()
        
        switch sender.state {
            
        case .began:
            
            startLocation = sender.location(in: self.view)
            
            if (startLocation.x >= 207){
                direction = "right"
            }else{
                direction = "left"
                
            }
            
            break;
            
        case .ended:
            
            let stopLocation = sender.location(in: self.view)
            
            if(direction == "left"){
                let dx = stopLocation.x;
                let distance = dx;
                if (distance >= 230) {
                    Router.shared.chooseScreen(ifLogeedInGoTo: "Meals")
                }
                foodImage.alpha = 0
            }
            if(direction == "right"){
                let dx = stopLocation.x;
                let distance = dx;
                if (distance <= 180) {
                    Router.shared.chooseScreen(ifLogeedInGoTo: "Workouts")
                    
                }
                workoutImage.alpha = 0
            }
            
            break;
            
        case .changed:
            if(direction == "left"){
                let distance = (sender.location(in:view).x) / 400
                print(distance)
                foodImage.alpha = distance - 0.2
            }
            if(direction == "right"){
                let distance = (sender.location(in:view).x) / 200
                print(distance)
                workoutImage.alpha = 1 - distance - 0.1
            }
            
            break;
            
        default:
            break;
        }
    }
}
