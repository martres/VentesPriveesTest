//
//  LoadingViewController.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 15/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var sunLoader: UIImageView!
    @IBOutlet weak var loaderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startLoaderAnimation()
    }

    func startLoaderAnimation() {
        
        UIView.animate(withDuration: 0.8, animations: { 
            self.loaderLabel.alpha = 0
        }) { (finish) in
            self.loaderLabel.text = "Loading ..."
            UIView.animate(withDuration: 0.6, animations: { 
                self.loaderLabel.alpha = 1
                self.sunLoader.rotate360Degrees()
            })
        }
    }

}
