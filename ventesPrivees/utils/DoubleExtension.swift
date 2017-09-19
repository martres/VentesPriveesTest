//
//  DoubleExtension.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 19/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation

extension Double {
    func getDateStringFromUnixTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
