//
//  RootObject.swift
//  weather_test
//
//  Created by nunzio giulio caggegi on 20/11/17.
//  Copyright © 2017 nunzio giulio caggegi. All rights reserved.
//

import Foundation
import SwiftyJSON

class RootClass{
    
    var base : String!
    var clouds : Cloud!
    var cod : Int!
    var coord : Coord!
    var dt : Int!
    var id : Int!
    var main : Main!
    var name : String!
    var sys : Sy!
    var visibility : Int!
    var weather : [Weather]!
    var wind : Wind!

    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        base = json["base"].stringValue
        let cloudsJson = json["clouds"]
        if cloudsJson != JSON.null{
            clouds = Cloud(fromJson: cloudsJson)
        }
        cod = json["cod"].intValue
        let coordJson = json["coord"]
        if coordJson != JSON.null{
            coord = Coord(fromJson: coordJson)
        }
        dt = json["dt"].intValue
        id = json["id"].intValue
        let mainJson = json["main"]
        if mainJson != JSON.null{
            main = Main(fromJson: mainJson)
        }
        name = json["name"].stringValue
        let sysJson = json["sys"]
        if sysJson != JSON.null{
            sys = Sy(fromJson: sysJson)
        }
        visibility = json["visibility"].intValue
        weather = [Weather]()
        let weatherArray = json["weather"].arrayValue
        for weatherJson in weatherArray{
            let value = Weather(fromJson: weatherJson)
            weather.append(value)
        }
        let windJson = json["wind"]
        if windJson != JSON.null{
            wind = Wind(fromJson: windJson)
        }
    }
    
    func codeBackground()->Int{
        return weather[0].id
    }
    
}
