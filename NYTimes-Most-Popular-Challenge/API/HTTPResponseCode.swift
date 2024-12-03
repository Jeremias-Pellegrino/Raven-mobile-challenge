//
//  APIClientError.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 28/11/2024.
//

import Foundation

struct HTTPResponseCode {
    
    enum HTTPResponseCategory: Error {
        case informativeResponse(Int)
        case satisfactoryResponse(Int)
        case clientError(Int)
        case redirection(Int)
        case serverError(Int)
        case other(Int)
    }
    
    let category: HTTPResponseCategory
    
    static func validate(_ code: Int) throws {
        let category: HTTPResponseCategory
        switch code {
        case 100...199:
            category = .informativeResponse(code)
        case 200...299:
            category = .satisfactoryResponse(code)
            return
        case 300...399:
            category = .redirection(code)
        case 400...499:
            category = .clientError(code)
        case 500...599:
            category = .serverError(code)
        default:
            category = .other(code)
        }
        
        throw category
    }
}
