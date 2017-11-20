//
//  girlshowsModel.swift
//  CodableExercises
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class GirlShow {
    let name: String
    let runtime: Int?
    let average: Double?
    let image: String?
    let summary: String
    
    init(name: String, runtime: Int?, average: Double?, image: String?, summary: String) {
        self.name = name
        self.runtime = runtime
        self.average = average
        self.image = image
        self.summary = summary
    }
    
    convenience init?(from jsonDict: [String: Any]) {
        
        //name
        guard let name = jsonDict["name"] as? String else { return nil }
        
        //runtime
        let runtime = jsonDict["runtime"] as? Int
        
        //average
        guard let ratingDict = jsonDict["rating"] as? [String: Any] else { return nil }
        let average = ratingDict["average"] as? Double
        
        //image
        var image: String?
        if let imageDict = jsonDict["image"] as? [String: Any] {
            image = imageDict["original"] as? String
        }
        
        //summary
        guard let summary = jsonDict["summary"] as? String else { return nil }
        
        self.init(name: name, runtime: runtime, average: average, image: image, summary: summary)
    }
    
    static func getGirlShows(from data: Data) -> [GirlShow] {
        var girlShows = [GirlShow]()
        
        do{
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let girlShowsDictArr = jsonDict as? [[String: Any]] else { return [] }
            
            for girlShowDict in girlShowsDictArr {
                guard let showDict = girlShowDict["show"] as? [String: Any] else {
                    continue
                }
                if let show = GirlShow(from: showDict) {
                    girlShows.append(show)
                }
            }
        } catch {
            print("///////////////////////")
            print(error.localizedDescription)
            print("///////////////////////")
        }
        return girlShows
    }
}

extension GirlShow: SubCellInfo {
    var textLabelText: String { return self.name }
    var detailTextLabelText: String { return self.summary }
    var imagePath: String? { return self.image }
}



