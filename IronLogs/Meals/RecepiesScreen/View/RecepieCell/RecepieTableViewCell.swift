//
//  RecepieTableViewCell.swift
//  IronLogs
//
//  Created by Meron Skop on 25/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class RecepieTableViewCell: UITableViewCell {

    @IBOutlet weak var one: UILabel!
    
    @IBOutlet weak var two: UILabel!
    
    @IBOutlet weak var three: UILabel!
    
    @IBOutlet weak var four: UILabel!
    
    @IBOutlet weak var five: UILabel!
    
    @IBOutlet weak var six: UILabel!
    
    @IBOutlet weak var seven: UILabel!
    
    func populateCell(recepie:APIFoodItem){
        one.text = "\(recepie.id)"
        two.text = recepie.image
        three.text = recepie.protein
        four.text = recepie.title
        five.text = "\(recepie.calories)"
        six.text = recepie.carbs
        seven.text = recepie.fat
    }
    
}
