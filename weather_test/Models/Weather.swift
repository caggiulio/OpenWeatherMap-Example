//
//  Weather.swift
//  weather_test
//
//  Created by nunzio giulio caggegi on 20/11/17.
//  Copyright © 2017 nunzio giulio caggegi. All rights reserved.
//

import Foundation
import SwiftyJSON

class Weather{
    
    var descriptionField : String!
    var icon : String!
    var id : Int!
    var main : String!

    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        descriptionField = json["description"].stringValue
        icon = json["icon"].stringValue
        id = json["id"].intValue
        main = json["main"].stringValue
    }
}
