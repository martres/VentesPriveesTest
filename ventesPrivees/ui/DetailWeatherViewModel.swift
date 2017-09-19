//
//  DetailWeatherViewModel.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 11/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit
import RealmSwift

class DetailWeatherViewModel {
    
    var forecastDetail: ForecastWeatherDate?
    var cityWeather: Results<CityWeather>?
    
    init(_ forecastDetail: ForecastWeatherDate) {
        self.forecastDetail = forecastDetail
        getData()
    }
    
    func getData() {
        do {
            cityWeather =  try RealmManager.get(objectType: CityWeather.self)
        } catch {
            print(error)
        }
    }

    func numberOfRow(inSection: Int) -> Int {
        if inSection == 0 {
            return 1
        }
        return forecastDetail?.arrayForecast.count ?? 0
    }
    
    func numberOfSection() -> Int {
        return 2
    }
}
