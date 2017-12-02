//
//  Coord.swift
//  weather_test
//
//  Created by nunzio giulio caggegi on 20/11/17.
//  Copyright © 2017 nunzio giulio caggegi. All rights reserved.
//

import Foundation
import SwiftyJSON

class Coord{
    
    var lat : Float!
    var lon : Float!

    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        lat = json["lat"].floatValue
        lon = json["lon"].floatValue
    }
    
}
