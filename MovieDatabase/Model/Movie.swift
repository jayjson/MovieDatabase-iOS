//
//  Movie.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-13.
//

import Foundation

struct PopularMovie: Equatable, Decodable, Hashable {
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

extension PopularMovie {
    var posterImageUrl: URL? {
        let secureBaseUrl =  "https://image.tmdb.org/t/p/"
        let sizePath = "w500"
        guard var urlComponents = URLComponents(string: secureBaseUrl) else { return nil }
        urlComponents.path += (sizePath + posterPath)
        return urlComponents.url
    }
}
