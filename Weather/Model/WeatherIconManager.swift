//
//  WeatherIconManager.swift
//  Weather
//
//  Created by Даниил Гетманцев on 29.11.2022.
//

import Foundation
import UIKit

//MARK: - Enum Icon

enum WeatherIconManager: String {
    case ClearSkyDay = "01d"
    case ClearSkyNight = "01n"
    case FewCloudsDay = "02d"
    case FewCloudsNight = "02n"
    case ScatteredCloudsDay = "03d"
    case ScatteredCloudsNight = "03n"
    case BrokenCloudsDay = "04d"
    case BrokenCloudsNight = "04n"
    case ShowerRainDay = "09d"
    case ShowerRainNight = "09n"
    case RainDay = "10d"
    case RainNight = "10n"
    case ThunderstormDay = "11d"
    case ThunderstormNight = "11n"
    case SnowDay = "13d"
    case ShowNight = "13n"
    case MistDay = "50d"
    case MistNight = "50n"
    case Unpredicted = "unpredicted-icon"
    
    init(rawValue: String) {
        switch rawValue {
        case "01d": self = .ClearSkyDay
        case "01n": self = .ClearSkyNight
        case "02d": self = .FewCloudsDay
        case "02n": self = .FewCloudsNight
        case "03d": self = .ScatteredCloudsDay
        case "03n": self = .ScatteredCloudsNight
        case "04d": self = .BrokenCloudsDay
        case "04n": self = .BrokenCloudsNight
        case "09d": self = .ShowerRainDay
        case "09n": self = .ShowerRainNight
        case "10d": self = .RainDay
        case "10n": self = .RainNight
        case "11d": self = .ThunderstormDay
        case "11n": self = .ThunderstormNight
        case "13d": self = .SnowDay
        case "13n": self = .ShowNight
        case "50d": self = .MistDay
        case "50n": self = .MistNight
        default: self = .Unpredicted
        }
    }
}

//MARK: - extension WeatherIconManager

extension WeatherIconManager {
    var image: UIImage{
        return UIImage(named: self.rawValue)!
    }
}
