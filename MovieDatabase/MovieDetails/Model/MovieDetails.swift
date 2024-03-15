//
//  MovieDetails.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-14.
//

import Foundation

struct MovieDetails: Equatable, Codable, Hashable {
    let backdropPath: String?
    let genres: [Genre]
    let id: Int
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let runtime: Int?
    let title: String
    let voteAverage: Double
    let credits: Credits
    let similar: SimilarMovies
}

extension MovieDetails: ImagePathContaining {
    var ratingText: String {
        String(format: "%.1f", voteAverage)
    }
    
    var backdropImageUrl: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return makeImageUrl(imagePath: backdropPath, sizePath: "w780")
    }
    
    var posterImageUrl: URL? {
        guard let posterPath = posterPath else { return nil }
        return makeImageUrl(imagePath: posterPath, sizePath: "w500")
    }
}
