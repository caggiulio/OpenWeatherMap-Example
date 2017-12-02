//
//  Main.swift
//  weather_test
//
//  Created by nunzio giulio caggegi on 20/11/17.
//  Copyright © 2017 nunzio giulio caggegi. All rights reserved.
//

import Foundation
//
//  Weather.swift
//
//
//  Created by nunzio giulio caggegi on 20/11/17.
//

import Foundation
import SwiftyJSON

class Main{
    
    var humidity : Int!
    var pressure : Int!
    var temp : Float!
    var tempMax : Float!
    var tempMin : Float!

    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        humidity = json["humidity"].intValue
        pressure = json["pressure"].intValue
        temp = json["temp"].floatValue - 273.15
        tempMax = json["temp_max"].floatValue - 273.15
        tempMin = json["temp_min"].floatValue - 273.15
    }
    
}
