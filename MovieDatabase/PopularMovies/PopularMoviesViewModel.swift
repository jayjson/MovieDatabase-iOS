//
//  PopularMoviesViewModel.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-13.
//

import Foundation
import SwiftUI

enum FetchPopularMoviesState: Equatable {
    case ready
    case inProgress
    case succeeded
    case failed(FetchMovieDataError)
}

final class PopularMoviesViewModel: ObservableObject {
    @Published private(set) var fetchPopularMoviesState: FetchPopularMoviesState = .ready
    @Published private(set) var popularMovies = [PopularMovie]()
    private var currentPageToFetch = 1
    private var canFetchMorePages = true
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func fetchPopularMovies() {
        guard canFetchMorePages, fetchPopularMoviesState != .inProgress else { return }        
        fetchPopularMoviesState = .inProgress
        Task {
            do {
                let moviesPage = try await repository.fetchPopularMovies(page: currentPageToFetch)
                await MainActor.run {
                    popularMovies += moviesPage.results
                    currentPageToFetch += 1
                    canFetchMorePages = !moviesPage.results.isEmpty
                    fetchPopularMoviesState = .succeeded
                }
            } catch {
                await MainActor.run {
                    if let popularMoviesError = error as? FetchMovieDataError {
                        fetchPopularMoviesState = .failed(popularMoviesError)
                    } else {
                        fetchPopularMoviesState = .failed(.unknown)
                    }
                    canFetchMorePages = false
                }
            }
        }
    }
    
    func fetchNextPageIfNeeded(movie: PopularMovie) {
        guard
            let currentIndex = popularMovies.firstIndex(of: movie),
            currentIndex > popularMovies.count-6
        else { return }
        fetchPopularMovies()
    }
}
