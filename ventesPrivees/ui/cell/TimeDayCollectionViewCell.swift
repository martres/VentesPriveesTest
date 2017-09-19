//
//  TimeDayCollectionViewCell.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 19/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class TimeDayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var pourcentageHumidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var descriptionWeather: UILabel!
    
    static var identifier = "TimeDayCollectionViewCell"
}
