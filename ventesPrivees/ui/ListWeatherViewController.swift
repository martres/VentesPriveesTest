//
//  ListWeatherViewController.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 11/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

/*
 *  TODO
 *  Add image Launch with animation will load data
 *  Design 
 *
 *
 */

class ListWeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherTableView : UITableView!
    
    var listWeatherModel: ListWeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    /*
     *  Function to send the data to the view detail
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vcDetail = segue.destination as? DetailWeatherViewController,segue.identifier == DetailWeatherViewController.segueIdentifier {
            
        }
    }
}

extension ListWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.estimatedRowHeight = 60
        weatherTableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: WeatherTableViewCell.identifier, bundle: nil)
        weatherTableView.register(nib, forCellReuseIdentifier: WeatherTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: DetailWeatherViewController.segueIdentifier, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listWeatherModel.numberOfRow(inSection: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listWeatherModel.numberOfSection() 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}
