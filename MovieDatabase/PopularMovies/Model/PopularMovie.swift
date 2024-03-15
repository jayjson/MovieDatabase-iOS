//
//  Movie.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-13.
//

import Foundation

struct PopularMovie: Equatable, Decodable, Hashable, MovieProtocol {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    var posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

extension PopularMovie: ImagePathContaining {
    var posterImageUrl: URL? {
        guard let posterPath = posterPath else { return nil }
        return makeImageUrl(imagePath: posterPath, sizePath: "w500")
    }
}
