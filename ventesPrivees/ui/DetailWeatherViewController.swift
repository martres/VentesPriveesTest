//
//  DetailWeatherViewController.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 11/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
    @IBOutlet weak var dayDetailCollectionView: UICollectionView!
    
    var detailWeatherModel: DetailWeatherViewModel!
    
    class func makeFromStoryboard() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailWeatherViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }
    
    //Mark: Action
    
    @IBAction func close(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func initCollectionView() {
        dayDetailCollectionView.delegate = self
        dayDetailCollectionView.dataSource = self
        dayDetailCollectionView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        
        let todayNib = UINib(nibName: TodayCollectionViewCell.identifier, bundle: nil)
        let timeNib = UINib(nibName: TimeDayCollectionViewCell.identifier, bundle: nil)
        
        dayDetailCollectionView.register(todayNib, forCellWithReuseIdentifier: TodayCollectionViewCell.identifier)
        dayDetailCollectionView.register(timeNib, forCellWithReuseIdentifier: TimeDayCollectionViewCell.identifier)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailWeatherModel.numberOfRow(inSection: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return detailWeatherModel.numberOfSection()
    }
    
    func makeTodayCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCollectionViewCell.identifier, for: indexPath) as? TodayCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.cityName.text = detailWeatherModel.cityWeather?.first?.name ?? ""
        let day = detailWeatherModel.forecastDetail
        if let icon = day?.arrayForecast[0].forecastDetails[0].icon {
            cell.currentWeatherIcon.loadImageWith(urlString: URLManager.urlForIconWeatherWith(name: icon))
        }
        cell.currentWeatherDescription.text = day?.arrayForecast[0].forecastDetails[0].descriptionWeather ?? ""
        if Calendar.current.compare((day?.date)!, to: Date(), toGranularity: .day) == .orderedSame {
            cell.date.text = "Today"
        } else {
            cell.date.text = day?.date.getCurrentDay()
        }
        
        if let longitude = detailWeatherModel.cityWeather?.first?.longitude, let latitude = detailWeatherModel.cityWeather?.first?.latitude {
            cell.location.text = "(\(longitude) , \(latitude))"
        }
        
        cell.maxTemp.text = day?.getMaxTemp() ?? ""
        cell.minTemp.text = day?.getMinTemp() ?? ""
        
        return cell
    }
    
    func makeTimeDayCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeDayCollectionViewCell.identifier, for: indexPath) as? TimeDayCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let forecast = detailWeatherModel.forecastDetail?.arrayForecast[indexPath.row] {
            cell.pourcentageHumidity.text = "humidity: \(forecast.humidity) %"
            cell.temp.text = "\(forecast.currentTemp) °C"
            cell.time.text = forecast.timeStamps.getDateStringFromUnixTime()
            cell.weatherIcon.loadImageWith(urlString: URLManager.urlForIconWeatherWith(name: forecast.forecastDetails[0].icon))
            cell.windSpeed.text = "\(forecast.windSpeed) meter by sec"
            cell.descriptionWeather.text = forecast.forecastDetails[0].descriptionWeather
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return makeTodayCell(collectionView, cellForItemAt: indexPath)
        }
        return makeTimeDayCell(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: collectionView.frame.size.width, height: 150)
        }
        return CGSize(width: collectionView.frame.size.width, height: 75)
    }
    
    
    
}
