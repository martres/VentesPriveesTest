//
//  ListWeatherViewModel.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 11/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit
import RealmSwift

struct ForecastWeatherDate {
    var date: Date = Date()
    var arrayForecast: [ForecastWeather]!
    
    mutating func add(forecast: ForecastWeather) {
        arrayForecast.append(forecast)
    }
    
    init(date: Date) {
        self.date = date
        self.arrayForecast = [ForecastWeather]()
    }
    
    func getMinTemp() -> String {
        var minTemp: Double = arrayForecast.first?.currentTemp ?? 100
        for item in arrayForecast {
            if item.currentTemp < minTemp {
                minTemp = item.currentTemp
            }
        }
        return "Min: \(Int(minTemp))°C"
    }
    
    func getMaxTemp() -> String {
        var maxTemp: Double = arrayForecast.first?.currentTemp ?? -10
        for item in arrayForecast {
            if item.currentTemp > maxTemp {
                maxTemp = item.currentTemp
            }
        }
        return "Max: \(Int(maxTemp))°C"
    }
}

class ListWeatherViewModel {
    
    var cityWeather: Results<CityWeather>?
    var days: [ForecastWeatherDate] = []
    
    init() {
        getData()
        if let arrayForecast = cityWeather?.first?.forecastData.toArray() {
            
            for item in arrayForecast {
                let currentDate = Date(timeIntervalSince1970: item.timeStamps)
                var isNew = true
                for (index, day) in days.enumerated() {
                    print(day.date, currentDate)
                    if Calendar.current.compare(day.date, to: currentDate, toGranularity: .day) == .orderedSame {
                        days[index].add(forecast: item)
                        isNew = false
                    }
                }
                
                if isNew {
                    days.append(ForecastWeatherDate(date: currentDate))
                    days[days.endIndex - 1].add(forecast: item)
                }
                
            }
        }
    }
    
    func getData() {
        do {
            cityWeather =  try RealmManager.get(objectType: CityWeather.self)
        } catch {
            print(error)
        }
    }
    
    func numberOfRow(inSection: Int) -> Int{
        return days.count
    }
    
    func numberOfSection() -> Int {
        return 1
    }

}
