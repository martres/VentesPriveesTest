//
//  NavigationManager.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 17/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit
import Foundation

class NavigationManager  {
    
    class func showMain(currentVC: UIViewController) {
        let vc = ListWeatherViewController.makeFromStoryboard()
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        guard let rootViewController = window.rootViewController else{
            return
        }
        
        vc.view.frame = rootViewController.view.frame
        vc.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .curveEaseIn, animations: { 
            window.rootViewController = vc
        }, completion: nil)
    }
    
    class func showDetail(currentVC: UIViewController, item: ForecastWeatherDate) {
        guard let vc = DetailWeatherViewController.makeFromStoryboard() as? DetailWeatherViewController else {
            return
        }
        let model = DetailWeatherViewModel(item)
        vc.detailWeatherModel = model
        currentVC.present(vc, animated: true, completion: nil)
    }
}
