//
//  LogInViewController.swift
//  IronLogs
//
//  Created by Meron Skop on 16/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit


class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let mViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /**
     This method
     Signs user in
     Moves to "Home.storyboard"
     */
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        guard isEmailValid && isPasswordValid,
            let email = emailTextField.text,
            let password = passwordTextField.text
            else{
                showError(title: "Please fill all fields")
                return
        }
        showProgress(title: "Logging In")
        mViewModel.logUserIn(email:email,password:password)
    }
    
    
}

extension LogInViewController:UserValidationLogIn{}
