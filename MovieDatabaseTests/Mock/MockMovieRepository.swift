//
//  MockMovieRepository.swift
//  MovieDatabaseTests
//
//  Created by Jay Son on 2024-03-14.
//

import Foundation
@testable import MovieDatabase

class MockMovieRepository: MovieRepository {
    var fetchPopularMoviesResult: Result<PopularMoviesResponse, FetchMovieDataError>!
    var fetchMovieDetailsResult: Result<MovieDetails, FetchMovieDataError>!
    
    var fetchPopularMoviesCallCount = 0
    var fetchMovieDetailsCallCount = 0
    
    func fetchPopularMovies(page: Int) async throws -> PopularMoviesResponse {
        fetchPopularMoviesCallCount += 1
        switch fetchPopularMoviesResult {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        default:
            fatalError("Fetch Popular Movies result not set")
        }
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieDetails {
        fetchMovieDetailsCallCount += 1
        switch fetchMovieDetailsResult {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        default:
            fatalError("Fetch Movie Details result not set")
        }
    }
}
