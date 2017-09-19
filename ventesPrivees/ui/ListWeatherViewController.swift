//
//  ListWeatherViewController.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 11/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class ListWeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherDaysCollectionView: UICollectionView!
    
    var listWeatherModel: ListWeatherViewModel = ListWeatherViewModel()
    
    class func makeFromStoryboard() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListWeatherViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = listWeatherModel.cityWeather?.first?.name

        initCollectionView()
        
    }
    
    /*
     *  Function to send the data to the view detail
     */
}

extension ListWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func initCollectionView() {
        weatherDaysCollectionView.delegate = self
        weatherDaysCollectionView.dataSource = self
        
        let todayNib = UINib(nibName: TodayCollectionViewCell.identifier, bundle: nil)
        let otherDayNib = UINib(nibName: OtherDayCollectionViewCell.identifier, bundle: nil)
        
        weatherDaysCollectionView.register(todayNib, forCellWithReuseIdentifier: TodayCollectionViewCell.identifier)
        weatherDaysCollectionView.register(otherDayNib, forCellWithReuseIdentifier: OtherDayCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.size.width, height: 150)
        }
        return CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.width / 2 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NavigationManager.showDetail(currentVC: self, item: listWeatherModel.days[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listWeatherModel.numberOfRow(inSection: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listWeatherModel.numberOfSection()
    }
    
    func makeTodayCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCollectionViewCell.identifier, for: indexPath) as? TodayCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.cityName.text = listWeatherModel.cityWeather?.first?.name ?? ""
        let day = listWeatherModel.days[indexPath.row]
        cell.currentWeatherIcon.loadImageWith(urlString: URLManager.urlForIconWeatherWith(name: day.arrayForecast[0].forecastDetails[0].icon))
        cell.currentWeatherDescription.text = day.arrayForecast[0].forecastDetails[0].descriptionWeather
        cell.date.text = "Today"
        
        if let longitude = listWeatherModel.cityWeather?.first?.longitude, let latitude = listWeatherModel.cityWeather?.first?.latitude {
            cell.location.text = "(\(longitude) , \(latitude))"
        }
        
        cell.maxTemp.text = day.getMaxTemp()
        cell.minTemp.text = day.getMinTemp()
        
        return cell
    }
    
    func makeOtherDayCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherDayCollectionViewCell.identifier, for: indexPath) as? OtherDayCollectionViewCell else {
            return UICollectionViewCell()
        }
        let day = listWeatherModel.days[indexPath.row]
        cell.date.text = day.date.getCurrentDay()
        cell.weatherIcon.loadImageWith(urlString: URLManager.urlForIconWeatherWith(name: day.arrayForecast[0].forecastDetails[0].icon))
        cell.minTemp.text = day.getMinTemp()
        cell.maxTemp.text = day.getMaxTemp()
        cell.viewRight.isHidden = indexPath.row % 2 == 0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            return makeTodayCell(collectionView, cellForItemAt: indexPath)
        }
        return makeOtherDayCell(collectionView, cellForItemAt: indexPath)
    }
}
