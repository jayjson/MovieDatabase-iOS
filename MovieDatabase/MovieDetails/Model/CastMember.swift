//
//  CastMember.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-14.
//

import Foundation

struct Credits: Equatable, Codable, Hashable {
    let cast: [CastMember]
}

struct CastMember: Equatable, Codable, Hashable {
    let adult: Bool
    let gender: Int?
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castId: Int?
    let character: String
    let creditId: String
    let order: Int
    
    var profileImageUrl: URL? {
        let secureBaseUrl =  "https://image.tmdb.org/t/p/"
        let sizePath = "w185"
        guard
            var urlComponents = URLComponents(string: secureBaseUrl),
            let profilePath = profilePath
        else { return nil }
        urlComponents.path += (sizePath + profilePath)
        return urlComponents.url
    }
}
