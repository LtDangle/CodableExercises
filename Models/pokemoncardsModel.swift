//
//  pokemoncardsModel.swift
//  CodableExercises
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class PokemonCard {
    let name: String
    let imageUrl: String
    let nationalPokedexNumber: Int?
    let rarity: String
    
    init(name: String, imageUrl: String, nationalPokedexNumber: Int?, rarity: String) {
        self.name = name
        self.imageUrl = imageUrl
        self.nationalPokedexNumber = nationalPokedexNumber
        self.rarity = rarity
    }
    
    convenience init?(from jsonDict: [String: Any]) {
        
        //name
        guard let name = jsonDict["name"] as? String else { return nil }
        
        //imageUrl
        guard let imageUrl = jsonDict["imageUrl"] as? String else { return nil }
        
        //nationalPokedexNumber
        let nationalPokedexNumber = jsonDict["nationalPokedexNumber"] as? Int
        
        //rarity
        guard let rarity = jsonDict["rarity"] as? String else { return nil }
        
        self.init(name: name, imageUrl: imageUrl, nationalPokedexNumber: nationalPokedexNumber, rarity: rarity)
    }
    
    static func getPokemonCards(from data: Data) -> [PokemonCard] {
        var pokemonCards = [PokemonCard]()
        do {
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let pokemonCardsDict = jsonDict as? [String: Any] else { return [] }
            guard let cardsDict = pokemonCardsDict["cards"] as? [[String: Any]] else { return [] }
            
            for card in cardsDict {
                if let card = PokemonCard(from: card) {
                    pokemonCards.append(card)
                } else {print("error in poke")}
            }
        } catch {
            print("///////////////////////")
            print(error.localizedDescription)
            print("///////////////////////")
        }
        return pokemonCards
    }
}

extension PokemonCard: SubCellInfo {
    var textLabelText: String { return self.name }
    var detailTextLabelText: String { return nationalPokedexNumber != nil ? String(self.nationalPokedexNumber!) : "N/A" }
    var imagePath: String? { return self.imageUrl }
}


