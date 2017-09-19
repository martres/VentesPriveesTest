//
//  URLManager.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 19/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation

class URLManager {
    
    class func urlForIconWeatherWith(name: String) -> String{
        return "http://openweathermap.org/img/w/\(name).png"
    }
    
    class func urlForWeatherData() -> String {
        return "http://api.openweathermap.org/data/2.5/forecast?id=2988507&appid=679543b4b7de127e4c93aa5c05a6eebd&units=metric"
    }
}
