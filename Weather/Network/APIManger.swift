//
//  APIManger.swift
//  Weather
//
//  Created by Даниил Гетманцев on 29.11.2022.
//

import Foundation

// MARK: - typealias
typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

// MARK: - enum APIResult

enum APIResult<T> {
    case Success(T)
    case SuccessArray([T])
    case Failure(Error)
}

// MARK: - protocol APIManager

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask
    func fetch<T: JSONDecodableCurrentWeather>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void)
    func fetch<T: JSONDecodableWeekWeather>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> [T]?, completionHandler: @escaping ([APIResult<T>]) -> Void)
    
}

// MARK: - Default use of the function

extension APIManager {
    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask {
        // TODO: The closure is responsible for checking the connection to the API
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let HTTPResponse = response as? HTTPURLResponse else {
                
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                let error = NSError(domain: WEANetworkingErrorDomain, code: 100, userInfo: userInfo)
                
                completionHandler(nil, nil, error)
                return
            }
            
            if data == nil {
                if let error = error {
                    completionHandler(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                        completionHandler(json, HTTPResponse, nil)
                    } catch let error as NSError {
                        completionHandler(nil, HTTPResponse, error)
                    }
                default:
                    print("We have got response status \(HTTPResponse.statusCode)")
                }
            }
        }
        return dataTask
    }
    
    func fetch<T>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void) {
        // TODO: The closure is responsible for checking whether it was possible to get today's weather data
        let dataTask = JSONTaskWith(request: request) { (json, response, error) in
                guard let json = json else {
                    if let error = error {
                        completionHandler(.Failure(error))
                    }
                    return
                }
                
                if let value = parse(json) {
                    completionHandler(.Success(value))
                } else {
                    let error = NSError(domain: WEANetworkingErrorDomain, code: 200, userInfo: nil)
                    completionHandler(.Failure(error))
                }
        }
        dataTask.resume()
    }
    
    func fetch<T: JSONDecodableWeekWeather>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> [T]?, completionHandler: @escaping ([APIResult<T>]) -> Void) {
        // TODO: The closure is responsible for checking whether it was possible to get weekly weather data 
        let dataTask = JSONTaskWith(request: request) { (json, response, error) in
                guard let json = json else {
                    if let error = error {
                        completionHandler([.Failure(error)])
                    }
                    return
                }

                if let value = parse(json) {
                    completionHandler([.SuccessArray(value)])
                } else {
                    let error = NSError(domain: WEANetworkingErrorDomain, code: 200, userInfo: nil)
                    completionHandler([.Failure(error)])
                }
        }
        dataTask.resume()
    }
    
}


