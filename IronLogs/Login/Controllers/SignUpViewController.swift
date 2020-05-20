//
//  SignUpViewController.swift
//  IronLogs
//
//  Created by Meron Skop on 16/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    let mViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
     This method
     Creates a new user in Firebase
     */
    @IBAction func sighnUpButtonTapped(_ sender: UIButton) {
        guard isPasswordValidAndMatching && isEmailValid && isNickNameValid,
            let password = passwordTextField.text,
            let email = emailTextField.text,
            let nickName = nickNameTextField.text
            else{
                if areEmailAndNickNameFull{
                    showError(subtitle: "Please make sure passwords are matching")
                }else{
                    showError(title: "Please fill all fields")
                }
                return
        }
        showProgress(title: "Registering")
        sender.isEnabled = false
        mViewModel.singnUserUp(email: email, password: password, nickName: nickName)
        sender.isEnabled = true
        
    }
    
    
    
}

extension SignUpViewController:UserValidationSignUp{}
