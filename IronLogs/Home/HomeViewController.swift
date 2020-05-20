//
//  HomeViewController.swift
//  IronLogs
//
//  Created by Meron Skop on 16/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

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
    
    @IBAction func workoutsButtonTapped(_ sender: UIButton) {
        Router.shared.chooseScreen(ifLogeedInGoTo: "Workouts")
    }
    
    @IBAction func mealsButtonTapped(_ sender: UIButton) {
        let mealsStoryboard = UIStoryboard(name: "Meals", bundle: .main)
        Router.shared.window?.rootViewController = mealsStoryboard.instantiateInitialViewController()
    }
    
    
    
}
