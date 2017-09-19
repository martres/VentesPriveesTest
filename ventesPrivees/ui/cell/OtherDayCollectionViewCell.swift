//
//  OtherDayCollectionViewCell.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 19/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class OtherDayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var viewRight: UIView!
    
    static var identifier = "OtherDayCollectionViewCell"
}
