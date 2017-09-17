//
//  ForecastDetailWeather.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 15/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class ForecastDetailWeather: Object, Mappable {
    
    dynamic var id = 0
    dynamic var main = ""
    dynamic var descriptionWeather = ""
    dynamic var icon = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        main                <- map["main"]
        descriptionWeather  <- map["description"]
        icon                <- map["icon"]
    }
}
