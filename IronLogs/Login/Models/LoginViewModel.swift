//
//  LoginViewModel.swift
//  IronLogs
//
//  Created by Meron Skop on 16/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

import FirebaseAuth


struct LoginViewModel {
    /**
     This method
     Loges user into Firebase
     */
     func logUserIn(email:String,password:String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            guard let _ = result else{
                let error = err?.localizedDescription ?? "Unknown error"
                self.showError(title: error)
                return
            }
            Router.shared.chooseScreen(ifLogeedInGoTo: "Home")
        }
    }
}

extension LoginViewModel:ShowHud{}
