//
//  TodayCollectionViewCell.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 19/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class TodayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentWeatherDescription: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    
    static var identifier = "TodayCollectionViewCell"
}
