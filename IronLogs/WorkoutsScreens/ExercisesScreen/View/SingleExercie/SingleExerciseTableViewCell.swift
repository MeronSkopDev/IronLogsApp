//
//  SingleExerciseTableViewCell.swift
//  9.4.2020LoginAndSaveToRealTimeDatabase
//
//  Created by Meron Skop on 19/04/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import UIKit

class SingleExerciseTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    var didSet = false
    
    /**
    This method
    Inserts given exerciseName into exerciseNameLabel
    */
    func initCell(exerciseName:String){
        exerciseNameLabel.text = exerciseName
    }
    
    func choosePic(lastImageNumChosen:Int) -> Int{
        if(!didSet){
            var imageNum = Int.random(in: 1...10)
            while(imageNum == lastImageNumChosen){
                imageNum = Int.random(in: 1...10)
            }
            backgroundImage.image = UIImage(named: "gymPic\(imageNum)")
            backgroundImage.layer.cornerRadius = 20.0
            backgroundImage.clipsToBounds = true
            self.didSet = true
            return imageNum
        }
        return 1
    }
}
