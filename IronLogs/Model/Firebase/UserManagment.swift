//
//  UserManagment.swift
//  IronLogs
//
//  Created by Meron Skop on 16/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth


protocol UserValidationLogIn {
    var emailTextField:UITextField!{get}
    var passwordTextField:UITextField!{get}
}

extension UserValidationLogIn{
    /**
    This var
    Makes sure that "emailTextField" is not empty
    */
    var isEmailValid:Bool{
        guard let email = emailTextField.text, !email.isEmpty else{
            return false
        }
        return true
    }
    /**
    This var
    Makes sure that "passwordTextField" is not empty
    */
    var isPasswordValid:Bool{
        guard let password = passwordTextField.text, !password.isEmpty else{
            return false
        }
        return true
    }
}

protocol UserValidationSignUp {
    var emailTextField:UITextField!{get}
    var passwordTextField:UITextField!{get}
    var confirmPasswordTextField:UITextField!{get}
    var nickNameTextField:UITextField!{get}
}

extension UserValidationSignUp{
    /**
     This var
     Makes sure that "emailTextField" is not empty
     */
    var isEmailValid:Bool{
        guard let email = emailTextField.text, !email.isEmpty else{
            return false
        }
        return true
    }
    /**
    This var
    Makes sure that "passwordTextField" is not empty
    */
    var isPasswordValidAndMatching:Bool{
        guard let password = passwordTextField.text, !password.isEmpty else{
            return false
        }
        guard let confirmationPass = confirmPasswordTextField.text, confirmationPass == password else{
            return false
        }
        return true
    }
    
    /**
    This var
    Makes sure that "emailTextField" and "nickNameTextField" are not empty
    */
    var areEmailAndNickNameFull:Bool{
        if isEmailValid && isEmailValid{
            return true
        }
        return false
    }
    /**
    This var
    Makes sure that "nickNameTextField" is not empty
    */
    var isNickNameValid:Bool{
        guard let nickName = nickNameTextField.text, !nickName.isEmpty else{
            return false
        }
        return true
    }
    
}
