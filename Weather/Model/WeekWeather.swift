//
//  WeekeWeather.swift
//  Weather
//
//  Created by Даниил Гетманцев on 29.11.2022.
//

import Foundation
import UIKit

//MARK: - protocol with WeektWeather

protocol JSONDecodableWeekWeather {
    init?(JSONMain: [String : AnyObject], JSONWeather: [String : AnyObject], JSONSys: [String : AnyObject])
}

//MARK: - Model WeektWeather

struct WeekWeather {
    let dateOfWeather: String
    let temperature: Double
    let icon: UIImage
}

//MARK: - extension WeektWeather: JSONDecodableWeekWeather

extension WeekWeather : JSONDecodableWeekWeather {
    init?(JSONMain: [String : AnyObject], JSONWeather: [String : AnyObject], JSONSys: [String : AnyObject]) {
        guard let temperature = JSONMain["temp"] as? Double,
              let dateOfWeather = JSONSys["dt_txt"] as? String,
              let iconString = JSONWeather["icon"] as? String else {
            return nil
        }
        let icon = WeatherIconManager(rawValue: iconString).image
        self.temperature = temperature
        self.dateOfWeather = dateOfWeather
        self.icon = icon
    }
}

//MARK: - extension WeektWeather

extension WeekWeather {
    var temperatureString: String {
        return "\(Int(temperature))°"
    }
}
