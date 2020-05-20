//
//  Box.swift
//  IronLogs
//
//  Created by Meron Skop on 17/05/2020.
//  Copyright © 2020 Skop.inc. All rights reserved.
//

import Foundation

class Box<T>{
    typealias Listener = (T) -> Void
    var listener:Listener?
    
    var value:T{
        didSet{
            listener?(value)
        }
    }
    
    init(_ value:T){
        self.value = value
    }
    
    func bind(listener:Listener?){
        self.listener = listener
        listener?(value)
    }
    
}

