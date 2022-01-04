//
//  SearchResult.swift
//  Crate
//
//  Created by Ashley Gong on 12/1/21.
//

import Foundation

class SearchResult: Codable {
    let count: Int
    let offset: Int
    let recordings: [Recordings]
}

class Recordings: Codable {
    let id: String
    let title: String
    let score: Int
    let artistCredit: [ArtistCredit]
    let firstReleaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case score
        case artistCredit = "artist-credit"
        case firstReleaseDate = "first-release-date"
    }
}

class ArtistCredit: Codable {
    let name: String
    let artist: Artist
}

class Artist: Codable {
    let id: String
    let name: String
}



