//
//  UIImageViewExtension.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 19/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImageWith(urlString: String) {
        let url = URL(string: urlString)
        self.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: nil)
    }
}
