//
//  City.swift
//  Weather
//
//  Created by Даниил Гетманцев on 06.12.2022.
//

import Foundation

//MARK: - Model City

struct City: Codable {
    let coords: Coordinates
    let district: String
    let name: String
    let subject: String
    
}

//MARK: - Extension City

extension City {
    var nameString: String {
        return "Название города: \(name)"
    }
    
    var subjectString: String {
        return "Регион: \(subject)"
    }
    
    var districtString: String {
        return "Федеральный округ: \(district)"
    }
}
