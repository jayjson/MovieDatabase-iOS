//
//  MoviesRepository.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-13.
//

import Foundation

protocol MovieRepository {
    func fetchPopularMovies() async throws -> [PopularMovie]
    func fetchMovieDetails() async throws -> MovieDetails
}
