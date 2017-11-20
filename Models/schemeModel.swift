//
//  schemeModel.swift
//  CodableExercises
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class Color {
    let hex: String
    let rgb: (r: Int, g: Int, b: Int)
    let name: String
    let image: String
    
    init(hex: String, rgb: (Int, Int, Int), name: String, image: String) {
        self.hex = hex
        self.rgb = rgb
        self.name = name
        self.image = image
    }
    
    convenience init?(from jsonDict: [String: Any]) {
        var c = 0
        //hex
        guard let hexDict = jsonDict["hex"] as? [String: Any] else {//could it say [String: String] ?
            print(c)
            return nil
        }
        c += 1
        guard let hex = hexDict["clean"] as? String else {
            print(c)
            return nil }
        c += 1
        //rgb
        guard let rgbDict = jsonDict["rgb"] as? [String: Any] else {
            return nil
        }
        guard
            let r = rgbDict["r"] as? Int,
            let g = rgbDict["g"] as? Int,
            let b = rgbDict["b"] as? Int
            else {
                print(c)
                return nil}
        let rgb = (r,g,b)
        c+=1
        //name
        guard let nameDict = jsonDict["name"] as? [String: Any] else {
            print(c)
            return nil
        }
        c+=1
        guard let name = nameDict["value"] as? String else {
            print(c)
            return nil }
        c+=1
        //image
        guard let imageDict = jsonDict["image"] as? [String: Any] else {
            print(c)
            return nil }
        c+=1
        guard let image = imageDict["named"] as? String else {
            print(c)
            return nil }
        
        self.init(hex: hex, rgb: rgb, name: name, image: image)
    }
    
    static func getColors(from data: Data) -> [Color] {
        var colors = [Color]()
        
        do {
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
            guard let schemeDict = jsonDict as? [String: Any] else {
                return []
            }
            guard let colorArr = schemeDict["colors"] as? [[String : Any]] else {
                return []
            }
            
            for colorDict in colorArr {
                if let color = Color(from: colorDict) {
                    colors.append(color)
                }
            }
        } catch {
            print("///////////////////////")
            print(error.localizedDescription)
            print("///////////////////////")
        }
        return colors
    }
}
extension Color: SubCellInfo {
    var textLabelText: String { return self.name }
    var detailTextLabelText: String { return self.hex }
    var imagePath: String? { return self.image}
}




