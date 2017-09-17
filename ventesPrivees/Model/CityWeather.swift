//
//  CountryWeather.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 15/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class CityWeather: Object, Mappable {
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var longitude = 0.0
    dynamic var latitude = 0.0
    dynamic var country = ""
    var forecastData = List<ForecastWeather>()
    
    override static func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id              <- map["city.id"]
        name            <- map["city.name"]
        longitude       <- map["city.coord.lon"]
        latitude        <- map["city.coord.lat"]
        country         <- map["city.country"]
        forecastData    <- (map["list"], ArrayTransform<ForecastWeather>())
    }
    
}
