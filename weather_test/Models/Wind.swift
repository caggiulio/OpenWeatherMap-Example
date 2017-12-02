//
//  Wind.swift
//  weather_test
//
//  Created by nunzio giulio caggegi on 20/11/17.
//  Copyright © 2017 nunzio giulio caggegi. All rights reserved.
//

import Foundation
import SwiftyJSON
class Wind{
    
    var deg : Int!
    var speed : Float!

    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        deg = json["deg"].intValue
        speed = json["speed"].floatValue
    }
    
}
