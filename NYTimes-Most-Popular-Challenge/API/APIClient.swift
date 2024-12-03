//
//  API.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 28/11/2024.
//

import Foundation

class APIClient {
    
    private var cache: URLCache
    private var session: URLSession
    var builder = RequestBuilder()
    
    init() {
        ///30 mb for each is more than enough.
        ///The most expensive memory items are images of around 0.1mb,  almost 300 images could be stored.
        cache = URLCache(memoryCapacity: 30 * 1024 * 1024,
                         diskCapacity: 30 * 1024 * 1024)
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        configuration.urlCache = cache
        session = URLSession(configuration: configuration)
    }

    func requestData(with url: URL, shouldCache: Bool = true) async throws -> Data {
        ///Instead of making new requests, revalidate what we already have.
        let request = URLRequest(url: url, cachePolicy: session.configuration.requestCachePolicy)
        
        if let cachedResponse = cache.cachedResponse(for: request) {
            return cachedResponse.data
        }
        
        return try await startDataTask(url: url, shouldCache: shouldCache)
    }
    
    func startDataTask(url: URL, shouldCache: Bool = false) async throws -> Data {

        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let validResponse = response as? HTTPURLResponse
        else {
            throw URLError(.badServerResponse)
        }
        
        try HTTPResponseCode.validate(validResponse.statusCode)
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)
        
        return data
    }
}
