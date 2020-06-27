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

    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        assignUserNameToLabel()
        
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        view.addGestureRecognizer(rightSwipeGesture)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        }
        
    }
    
    
    
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        if sender.state == .ended{
            switch sender.direction {
            case .right:
                let mealsStoryboard = UIStoryboard(name: "Meals", bundle: .main)
                Router.shared.window?.rootViewController = mealsStoryboard.instantiateInitialViewController()
                break;
            case .left:
                Router.shared.chooseScreen(ifLogeedInGoTo: "Workouts")
                break;
            default:
                break;
            }
        }
    }
}
