//
//  PopularMovie+Mocks.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-15.
//

import Foundation

extension PopularMovie {
    static var withPoster: PopularMovie {
        PopularMovie(
            adult: false,
            backdropPath: "/gJL5kp5FMopB2sN4WZYnNT5uO0u.jpg",
            genreIds: [28, 12, 16, 35, 10751],
            id: 1011985,
            originalLanguage: "en",
            originalTitle: "Kung Fu Panda 4",
            overview: "Po is gearing up to become the spiritual leader of his Valley of Peace...",
            popularity: 1652.671,
            posterPath: "/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg",
            releaseDate: "2024-03-02",
            title: "Kung Fu Panda 4",
            video: false,
            voteAverage: 7.0,
            voteCount: 74
        )
    }
    
    static var withoutPoster: PopularMovie {
        PopularMovie(
            adult: false,
            backdropPath: nil,
            genreIds: [28, 12, 16, 35, 10751],
            id: 1011986,
            originalLanguage: "en",
            originalTitle: "Kung Fu Panda 4",
            overview: "An untold story of adventure...",
            popularity: 1020.0,
            posterPath: nil,
            releaseDate: "2024-05-06",
            title: "Kung Fu Panda 9",
            video: false,
            voteAverage: 6.5,
            voteCount: 30
        )
    }
}
