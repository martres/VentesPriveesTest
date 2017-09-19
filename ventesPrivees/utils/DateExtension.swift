//
//  DateExtension.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 19/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation

extension Date {
    
    static var days = ["", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    func transformTo(format: String = "dd-MM-yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getCurrentDay() -> String {
        let now = Calendar.current.component(.weekday, from: self)
        return Date.days[now]
    }
}
