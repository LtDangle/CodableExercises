//
//  citiesModel.swift
//  CodableExercises
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class City {
    let name: String
    let weather: String
    
    init(name: String, weather: String) {
        self.name = name
        self.weather = weather
    }
    
    convenience init?(from jsonDict: [String: Any]) {
        guard let name = jsonDict["name"] as? String else {
            return nil
        }
        guard let weatherArr =  jsonDict["weather"] as? [[String: Any]] else {
            return nil
        }
        guard let weatherDict = weatherArr.first else {
            return nil
        }
        guard let weather = weatherDict["description"] as? String else {
            return nil
        }
        
        self.init(name: name, weather: weather)
    }
    
    static func getCities(from data: Data) -> [City] {
        var cities = [City]()
        do {
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
            if let citiesDict = jsonDict as? [String: Any] {
                guard let list = citiesDict["list"] as? [[String: Any]] else {
                    return []
                }
                for cityDict in list {
                    if let city = City(from: cityDict) {
                        cities.append(city)
                    }
                }
            }
        } catch {
            print("////////////////////////")
            print(error.localizedDescription)
            print("////////////////////////")
        }
        
        return cities
    }
}

extension City: SubCellInfo {
    var textLabelText: String { return self.name }
    var detailTextLabelText: String { return self.weather }
    var imagePath: String? { return nil }
}



