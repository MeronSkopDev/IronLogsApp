//
//  DayOfEatingTitleTableViewCell.swift
//  IronLogs
//
//  Created by Meron Skop on 19/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class DayOfEatingTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTextField: UITextField!
    
    func populateCell(title:String?){
        titleTextField.text = title ?? "New day"
    }
    
}
