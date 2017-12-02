//
//  Networking.swift
//  weather_test
//
//  Created by nunzio giulio caggegi on 20/11/17.
//  Copyright © 2017 nunzio giulio caggegi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum AsyncResult<T>
{
    case Success(T)
    case Error(T)
    case Failure(T)
}

public class Api{
    
    class func request(method: Alamofire.HTTPMethod, URIString: String, parameters: [String : AnyObject]?, completion: @escaping (AsyncResult<JSON>)->()) -> DataRequest {
    
        return Alamofire.request(Config.ApiHost+URIString, method: method, parameters: parameters).validate(statusCode: 200..<300)
            .responseJSON { response in
                let json = JSON(data: response.data!)
                if (response.result.error == nil) {
                    completion(AsyncResult.Success(json))
                }
                else {
                    completion(AsyncResult.Error(json))
                }
        }
    }
    
    class func cityRequest(params: [String:AnyObject]?, completion: @escaping (AsyncResult<JSON>)->()){
     self.request(method: .get, URIString: "/data/2.5/weather", parameters: params){ (result) in
            completion(result)
        }
    }
    
}
