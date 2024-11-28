//
//  API.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 28/11/2024.
//

import Foundation

class APIClient {
    
    let cache: URLCache
    
    init() {

        if let apiKey = ProcessInfo.processInfo.environment["RAVEN_KEY"] {
            print("API Key: \(apiKey)")
        } else {
            print("API Key not found")
        }

        cache = URLCache(memoryCapacity: 50 * 1024 * 1024,
                         diskCapacity: 200 * 1024 * 1024,
                         diskPath: nil)
    }
    
    func requestData(with url: URL, shouldCache: Bool = true) async throws -> Data {
        
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)) {
            return cachedResponse.data
        }
        
        return try await startDataTask(url: url, shouldCache: shouldCache)
    }
    
    func startDataTask(url: URL, shouldCache: Bool = false) async throws -> Data {

        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let validResponse = response as? HTTPURLResponse
        else {
            throw URLError(.badServerResponse, userInfo: [:])
        }
        
        let responseCode = HTTPResponseCode(validResponse.statusCode)
        
        if !responseCode.isSatisfactory {
            throw responseCode.category
        }

        return data
    }
}
