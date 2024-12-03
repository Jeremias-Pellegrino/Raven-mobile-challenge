//
//  Bookmarks.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 02/12/2024.
//

import Foundation

@Observable
class Bookmarks {
    private var storage = Storage()
    private let key = "Bookmars"
    public private(set) var articles: [Article]
    
    init() {
        self.articles = []
        guard let bookmarks = try? storage.loadAndDecode(from: key, to: [Article].self)
        else { return }
        
        self.articles = bookmarks
    }

    func contains(_ article: Article) -> Bool {
        articles.contains(article)
    }

    func add(_ article: Article) {
        articles.append(article)
        save()
    }

    func remove(_ article: Article) {
        articles.removeAll { $0.id == article.id }
        save()
    }

    func save() {
       try? storage.encodeAndSave(item: articles, to: key)
    }
}
