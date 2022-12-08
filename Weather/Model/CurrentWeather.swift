//
//  CurrentWeatherModel.swift
//  Weather
//
//  Created by Даниил Гетманцев on 29.11.2022.
//

import Foundation
import UIKit

//MARK: - protocol with CurrentWeather

protocol JSONDecodableCurrentWeather {
    init?(JSONMain: [String : AnyObject], JSONWeather: [String : AnyObject], JSON: [String : AnyObject])
}

//MARK: - Model CurrentWeather

struct CurrentWeather {
    let temperature: Double
    let tempMin: Double
    let tempMax: Double
    let tempFilsLike : Double
    let humidity: Double
    let pressure: Double
    let city: String
    let icon: UIImage
}

//MARK: - Extension CurrentWeather: JSONDecodableCurrentWeather

extension CurrentWeather: JSONDecodableCurrentWeather {
    init?(JSONMain: [String : AnyObject], JSONWeather: [String : AnyObject], JSON: [String : AnyObject]) {
        guard let temperature = JSONMain["temp"] as? Double,
              let tempMin = JSONMain["temp_min"] as? Double,
              let tempMax = JSONMain["temp_max"] as? Double,
              let tempFilsLike = JSONMain["feels_like"] as? Double,
              let humidity = JSONMain["humidity"] as? Double,
              let pressure = JSONMain["pressure"] as? Double,
              let iconString = JSONWeather["icon"] as? String,
              let city = JSON["name"] as? String else {
            return nil
        }
        let icon = WeatherIconManager(rawValue: iconString).image
        self.temperature = temperature
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.tempFilsLike = tempFilsLike
        self.humidity = humidity
        self.pressure = pressure
        self.city = city
        self.icon = icon
    }
}

//MARK: - Extension CurrentWeather

extension CurrentWeather {
    var temperatureString: String {
        return "\(Int(temperature))C°"
    }
    
    var tempMinMaxString: String {
        return "\(Int(tempMin))°/\(Int(tempMax))°"
    }
    
    var tempFilsLikeString: String {
        return "Ощущаеться как: \(Int(tempFilsLike))°"
    }
    
    var humidityString: String {
        return "\(Int(humidity)) %"
    }
    
    var pressureString: String {
        return "\(Int(pressure)) mm"
    }
}
