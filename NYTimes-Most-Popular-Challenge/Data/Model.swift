//
//  Model.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 28/11/2024.
//

import Foundation

struct MostPopular: Codable {
    let status, copyright: String
    let numResults: Int
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case articles = "results"
    }
}

class Article: Codable, Equatable {
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.id == rhs.id
    }
    
    let uri: String
    let url: String
    let id, assetID: Int
    let source: Source
    let publishedDate, updated, section, subsection: String
    let nytdsection, adxKeywords: String
    let byline: String
    let type: ResultType
    let title, abstract: String
    let desFacet, orgFacet, perFacet, geoFacet: [String]
    let media: [Media]
    let etaID: Int

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case byline, type, title, abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }
}

struct Media: Codable {
    let type: MediaType
    let subtype: Subtype
    let caption, copyright: String
    let approvedForSyndication: Int
    let mediaMetadata: [MediaMetadatum]

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadatum: Codable {
    let url: String
    let format: Format
    let height, width: Int
}

enum Format: String, Codable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}

enum Subtype: String, Codable {
    case empty = ""
    case photo = "photo"
}

// estos dos pueden ser eliminados
    enum MediaType: String, Codable {
        case image = "image"
    }

    enum Source: String, Codable {
        case newYorkTimes = "New York Times"
    }

enum ResultType: String, Codable {
    case article = "Article"
    case interactive = "Interactive"
}
