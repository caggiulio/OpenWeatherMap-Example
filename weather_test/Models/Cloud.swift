//
//  Cloud.swift
//  weather_test
//
//  Created by nunzio giulio caggegi on 20/11/17.
//  Copyright © 2017 nunzio giulio caggegi. All rights reserved.
//

import Foundation
import SwiftyJSON

class Cloud{
    
    var all : Int!

    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        all = json["all"].intValue
    }
    
}
