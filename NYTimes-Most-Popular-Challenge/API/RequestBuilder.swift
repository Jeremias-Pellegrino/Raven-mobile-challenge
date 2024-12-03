//
//  RequestBuilder.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 28/11/2024.
//

import Foundation

enum DaysPeriod: Int, CaseIterable, Codable {
    case one = 1
    case seven = 7
    case thirty = 30
}

enum ArticleCategory: String, CaseIterable, Codable {
    case emailed
    case shared
    case viewed
}

class RequestBuilder {
    
    private var apiKey: String? = nil
    private var components = URLComponents()
    
    init() {
        self.apiKey = try? retrieveAPIKey()
        setupComponents()
    }
    
    //For this challenge presentation/testing purposes we return it directly from here. In a real scenario this should be stored somewhere else, securely.
    private func retrieveAPIKey() throws -> String {
        return "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ"
//        guard let apiKey = retrieveApiKeyFromKeychainOrSomeExternalService() else {
//            throw Error.cantRetrieveAPIKey
//        }
//        return apiKey
    }
    
    private func setupComponents()  {
        components.scheme = "https"
        components.host = "api.nytimes.com"
        components.path = "/svc/mostpopular/v2/"
    }
 
    func endpoint(daysPeriod: DaysPeriod, category: ArticleCategory) throws -> URL {
        var components = self.components
        components.path.append(contentsOf: "\(category)/\(daysPeriod.rawValue).json")
        components.queryItems = [
            URLQueryItem(name: "api-key", value: apiKey),
        ]
        guard let url = components.url
        else {
            throw URLError(.badURL)
        }
        
        return url
    }
}
