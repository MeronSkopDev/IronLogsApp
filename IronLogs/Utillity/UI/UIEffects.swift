//
//  UIEffects.swift
//  IronLogs
//
//  Created by Meron Skop on 16/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

import PKHUD

protocol ShowHud {
    
}

extension ShowHud{
    /**
     This method
     Shows a PKHUD succsess prompet
     */
    func showProgress(title:String? = nil,subtitle:String? = nil){
        HUD.show(.labeledProgress(title: title, subtitle: subtitle))
    }
    /**
    This method
    Flashes a PKHUD Error prompet
    */
    func showError(title:String? = nil,subtitle:String? = nil){
        HUD.flash(.labeledError(title: title, subtitle: subtitle) , delay: 1)
    }
    /**
    This method
    Flashes a PKHUD Success prompet
    */
    func showSuccsess(title:String? = nil,subtitle:String? = nil){
        HUD.flash(.labeledSuccess(title: title, subtitle: subtitle) , delay: 1)
    }
    /**
    This method
    Flashes a PKHUD Label prompet
    */
    func showLabel(title:String){
        HUD.flash(.label(title), delay: 1)
    }
}
///We give all UIViewController's the option to show PKHUD promptes
extension UIViewController:ShowHud{}
