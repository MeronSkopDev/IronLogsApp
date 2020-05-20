//
//  SignUpViewModel.swift
//  IronLogs
//
//  Created by Meron Skop on 16/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation
import FirebaseAuth


struct SignUpViewModel{
    
    /**
     This method
     Cretes a new user in FireStore according to given params
     Moves to "Home.storyboard"
     */
    func singnUserUp(email:String,password:String,nickName:String){
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            guard let res = res else{
                let err = err
                self.showError(title: err?.localizedDescription)
                return
            }
            let user = res.user
            let requestToChangeDisplayName = user.createProfileChangeRequest()
            requestToChangeDisplayName.displayName = nickName
            requestToChangeDisplayName.commitChanges { (err) in
                if err != nil{
                    self.showError(subtitle: err!.localizedDescription)
                }else{
                    self.showSuccsess()
                    Router.shared.chooseScreen(ifLogeedInGoTo: "Home")
                }
            }
        }
    }
}

extension SignUpViewModel:ShowHud{}
