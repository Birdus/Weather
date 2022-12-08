//
//  APIWeatherManager.swift
//  Weather
//
//  Created by Даниил Гетманцев on 29.11.2022.
//

import Foundation

// MARK: - protocol FinalURLPoint

protocol FinalURLPoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

// MARK: - enum ForecastType: FinalURLPoint

enum ForecastType: FinalURLPoint {
    
    case CurrentCord(apiKey: String, coordinates: Coordinates)
    case WeekCord(apiKey: String, coordinates: Coordinates)
    
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org")!
    }
    
    var path: String {
        switch self {
        case .CurrentCord(let apiKey, let coordinates):
            return "/data/2.5/weather?lat=\(coordinates.lat)&lon=\(coordinates.lon)&exclude=current&APPID=\(apiKey)&lang=ru&units=metric"
        case .WeekCord(let apiKey, let coordinates):
            return "/data/2.5/forecast?lat=\(coordinates.lat)&lon=\(coordinates.lon)&exclude=current&APPID=\(apiKey)&lang=ru&units=metric"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
}

// MARK: - APIManagerWeather

final class APIManagerWeather: APIManager {
    // MARK: internal variable
    
    internal let sessionConfiguration: URLSessionConfiguration
    internal lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    } ()
    
    // MARK: private variable
    
    private let apiKey: String
    
    // MARK: Inecializers
    
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    // MARK: Public func
    
    func fetchCurrentWeatherWith(coordinates: Coordinates, completionHandler: @escaping (APIResult<CurrentWeather>) -> Void) {
        // TODO: The closure is responsible for checking whether it was possible to parse the data for the current weather
        let request = ForecastType.CurrentCord(apiKey: self.apiKey, coordinates: coordinates).request
        fetch(request: request, parse: { (json) -> CurrentWeather? in
            if let dictionary = json["main"] as? [String: AnyObject],
               let arrayWeather = json["weather"] as? [AnyObject],
               let dictionaryWeather = arrayWeather[0] as? [String:AnyObject]{
                return CurrentWeather(JSONMain: dictionary, JSONWeather: dictionaryWeather, JSON: json)
            } else {
                return nil
            }
            
        }, completionHandler: completionHandler)
    }
    
    func fetchWeekWeatherWith(coordinates: Coordinates, completionHandler: @escaping ([APIResult<WeekWeather>]) -> Void) {
        // TODO: The closure is responsible for checking whether it was possible to parse the data for the week weather
        var arrayWeekWeather = [WeekWeather]()
        let request = ForecastType.WeekCord(apiKey: self.apiKey, coordinates: coordinates).request
        fetch(request: request, parse: { (json) -> [WeekWeather]? in
            if let dictionary = json["list"] as? [AnyObject]{
                for elementWeathear in dictionary {
                    if let JSONMain = elementWeathear["main"] as? [String: AnyObject],
                       let  JSONWeather = elementWeathear["weather"] as? [AnyObject],
                       let  elementIconWeather = JSONWeather[0] as? [String: AnyObject]{
                        arrayWeekWeather.append(WeekWeather(JSONMain: JSONMain, JSONWeather: elementIconWeather, JSONSys: elementWeathear as! [String : AnyObject])!)
                    }
                }
                return arrayWeekWeather
            } else {
                return nil
            }
        }, completionHandler: completionHandler)
    }
}

