//
//  ForecastWeather.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 15/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

var idAutoIncrement = 0

class ForecastWeather: Object, Mappable {
    
    dynamic var id = 0
    dynamic var currentTemp = 0.0
    dynamic var sea_level = 0.0
    dynamic var humidity = 0.0
    dynamic var currentDate = ""
    dynamic var timeStamps = 0.0
    dynamic var windSpeed = 0.0
    var forecastDetails = List<ForecastDetailWeather>()
        
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    class func incrementID() -> Int {
        idAutoIncrement += 1
        return idAutoIncrement
    }
    
    func mapping(map: Map) {
        id = ForecastWeather.incrementID()
        currentTemp     <- map["main.temp"]
        sea_level       <- map["main.sea_level"]
        humidity        <- map["main.humidity"]
        windSpeed       <- map["wind.speed"]        
        currentDate     <- map["dt_txt"]
        timeStamps      <- map["dt"]
        forecastDetails <- (map["weather"], ArrayTransform<ForecastDetailWeather>())
    }
}
