//
//  MoviesRepository.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-13.
//

import Foundation

protocol MovieRepository {
    func fetchPopularMovies(page: Int) async throws -> PopularMoviesResponse
    func fetchMovieDetails(id: Int) async throws -> MovieDetails
}
