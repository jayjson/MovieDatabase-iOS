//
//  SimilarMovie.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-14.
//

import Foundation

struct SimilarMovies: Equatable, Codable, Hashable {
    let page: Int
    let results: [SimilarMovie]
    let totalPages: Int
    let totalResults: Int
}

struct SimilarMovie: Equatable, Codable, Hashable, MovieProtocol {
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

extension SimilarMovie: ImagePathContaining {
    var posterImageUrl: URL? {
        guard let posterPath = posterPath else { return nil }
        return makeImageUrl(imagePath: posterPath, sizePath: "w500")
    }
}
