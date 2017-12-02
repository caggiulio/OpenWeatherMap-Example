//
//  Sy.swift
//  weather_test
//
//  Created by nunzio giulio caggegi on 20/11/17.
//  Copyright © 2017 nunzio giulio caggegi. All rights reserved.
//

import Foundation
import SwiftyJSON

class Sy{
    
    var country : String!
    var id : Int!
    var message : Double!
    var sunrise : Int!
    var sunset : Int!
    var type : Int!

    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        country = json["country"].stringValue
        id = json["id"].intValue
        message = json["message"].doubleValue
        sunrise = json["sunrise"].intValue
        sunset = json["sunset"].intValue
        type = json["type"].intValue
    }
    
    func calcSunrise()->Date{
        return Date(timeIntervalSince1970: Double(sunrise))
    }
    
    func calcSunset()->Date{
        return Date(timeIntervalSince1970: Double(sunset))
    }
    
}
