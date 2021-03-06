//
//  WorkoutsTableViewCell.swift
//  9.4.2020LoginAndSaveToRealTimeDatabase
//
//  Created by Meron Skop on 11/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class WorkoutsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var backroundImage: UIImageView!
    
    var didSet = false
    
    /**
     This method
     Inserts given detais into titleLabel and dateLabel
     */
    func updateCell(workoutDetails:Workout.WorkoutDetails){
        titleLabel.text = workoutDetails.title
        dateLabel.text = workoutDetails.dateOfCreation
        
        titleLabel.layer.masksToBounds = true
        
        dateLabel.layer.masksToBounds = true
    }
    
    func choosePic(lastImageNumChosen:Int) -> Int{
        if(!didSet){
            didSet = !didSet
            return  ImageLoading.choosePic(
                lastImageNumChosen: lastImageNumChosen,
                imageView: backroundImage,
                lastImageNum: 10,
                imageName: "gymPic")
        }
        return 1
    }
    
    
    
}
