//
//  WeatherModel.swift
//  Clima
//
//  Created by Dhruva Beti on 13/01/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct WeatherModel {
    let city:String
    let temp:Double
    let id:Int
    
    //Computed property
    var tempString:String{
        return String(format: "%.1f", temp)
    }
    
    //Computed property
    var conditionImage:UIImage{
        return UIImage(systemName: weahterImageString) ?? UIImage()
    }
    
    //Computed property
    var weahterImageString:String{
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
