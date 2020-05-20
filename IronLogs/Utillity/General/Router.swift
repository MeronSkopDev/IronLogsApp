//
//  Router.swift
//  IronLogs
//
//  Created by Meron Skop on 16/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

import UIKit

import FirebaseAuth

class Router{
    private init(){}
    static let shared = Router()
    
    weak var window:UIWindow?
    
    /**
     This var
     Checks if there is a user logged in
     */
    var isUserLoggedIn:Bool{
        return Auth.auth().currentUser != nil
    }
    
    /**
     This method
     First makes sure that it runs on the main thread
     Checks if the user is logged in
        If true moves to "ifLogeedInGoTo" storyboard
        If false moves to "Login" storyboard
     */
    func chooseScreen(ifLogeedInGoTo:String){
        //Here we make sure this method will allways run on the main thread
        guard Thread.current.isMainThread else{
            DispatchQueue.main.async {[weak self] in
                self?.chooseScreen(ifLogeedInGoTo: ifLogeedInGoTo)
            }
            return
        }
        
        let storyBoardChosen = isUserLoggedIn ? ifLogeedInGoTo : "Login"
        let chosenStoryBoard = UIStoryboard(name: storyBoardChosen, bundle: .main)
        window?.rootViewController = chosenStoryBoard.instantiateInitialViewController()
    }
}
