//
//  newsModel.swift
//  CodableExercises
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class Article {
    let title: String
    let author: String
    let description: String
    let urlToImage: String
    
    init(title: String, author: String, description: String, urlToImage: String) {
        self.title = title
        self.author = author
        self.description = description
        self.urlToImage = urlToImage
    }
    
    convenience init?(from jsonDict: [String: Any]) {
        //title
        guard let title = jsonDict["title"] as? String else { return nil }
        
        //author
        guard let author = jsonDict["author"] as? String else { return nil }
        
        //description
        guard let description = jsonDict["description"] as? String else { return nil }
        
        //urlToImage
        guard let urlToImage = jsonDict["urlToImage"] as? String else { return nil }
        
        self.init(title: title, author: author, description: description, urlToImage: urlToImage)
    }
    
    static func getArticles(from data: Data) -> [Article] {
        var articles = [Article]()
        
        do {
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let newsDict = jsonDict as? [String: Any] else { return [] }
            guard let articlesArr = newsDict["articles"] as? [[String: Any]] else { return [] }
            
            for article in articlesArr {
                if let article = Article(from: article) {
                    articles.append(article)
                }
            }
        } catch {
            print("///////////////////////")
            print(error.localizedDescription)
            print("///////////////////////")
        }
        return articles
    }
}

extension Article: SubCellInfo {
    var textLabelText: String { return self.title }
    var detailTextLabelText: String { return self.description }
    var imagePath: String? { return self.urlToImage}
}


