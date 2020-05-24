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
    
    var dayOfEating:DayOfEating?
    
    /**
    This method
    Filles up all the TextField with the data from the "DayOfEating"
    */
    func populateCell(dayOfEating:DayOfEating){
        titleTextField.text = dayOfEating.title ?? "New day"
        self.dayOfEating = dayOfEating
    }
    
    /**
     This method
     Adds a target to "titleTextField" that recognizes when the text is changed
     */
    func initObserver(){
        titleTextField.addTarget(self, action: #selector(changeDayOfEatingTitle(_:)), for: .editingChanged)
    }
    
    /**
     This method
     Saves the title the user inputed in the "DayOfEating"
     */
    @objc func changeDayOfEatingTitle(_ sender:UITextField){
        dayOfEating?.title = sender.text
        CM.shared.saveContext()
    }
    
    
}
