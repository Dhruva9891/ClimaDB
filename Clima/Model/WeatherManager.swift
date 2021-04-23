//
//  WeatherManager.swift
//  Clima
//
//  Created by Dhruva Beti on 11/01/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func updateUI(weatherModel:WeatherModel)
    func didFailWithError(_ error:Error)
}

class WeatherManager {
    
    var delegate:WeatherManagerDelegate?
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=aa0781695c02310362b5bc8e2ddf52f0&units=metric"
    
    func fetchWeather(cityName:String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlStr: urlString)
    }
    
    func fetchWeather(lat:CLLocationDegrees,lon:CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(urlStr: urlString)
    }
    
    func performRequest(urlStr:String){
        //1.Create url
        if let url = URL(string: urlStr){
            
            //2.Create url session
            let session = URLSession(configuration: .default)
            
            //3.Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if  let error = error{
                    self.delegate?.didFailWithError(error)
                }
                                
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    if let weatherModel = self.parseJSON(weatherData: safeData){
                        self.delegate?.updateUI(weatherModel: weatherModel)
                    }

                }
            }
            
            //4.Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedDataObject = try decoder.decode(WeatherData.self, from: weatherData)
            
            let weatherModel = WeatherModel(city: decodedDataObject.name, temp: decodedDataObject.main.temp, id:  decodedDataObject.weather[0].id)
            
            return weatherModel
            
        } catch{
            delegate?.didFailWithError(error)
            return nil
        }
        
    }
    
}
