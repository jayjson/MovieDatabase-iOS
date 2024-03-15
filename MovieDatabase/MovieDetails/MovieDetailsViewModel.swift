//
//  MovieDetailsViewModel.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-14.
//

import Foundation

enum FetchMovieDetailsState: Equatable {
    case ready
    case inProgress
    case succeeded
    case failed(FetchMovieDataError)
}

final class MovieDetailsViewModel: ObservableObject {
    @Published private(set) var fetchMovieDetailsState: FetchMovieDetailsState = .ready
    @Published private(set) var movieDetails: MovieDetails?
    
    let title: String
    private let movieId: Int
    private let repository: MovieRepository
    
    init(title: String, movieId: Int, repository: MovieRepository) {
        self.title = title
        self.movieId = movieId
        self.repository = repository
    }
    
    func fetchMovieDetails() {
        guard movieDetails == nil, fetchMovieDetailsState != .inProgress else { return }

        fetchMovieDetailsState = .inProgress
        Task {
            do {
                let fetchedMovieDetails = try await repository.fetchMovieDetails(id: movieId)
                await MainActor.run {
                    fetchMovieDetailsState = .succeeded
                    movieDetails = fetchedMovieDetails
                }
            } catch  {
                await MainActor.run {
                    if let movieDetailsError = error as? FetchMovieDataError {
                        fetchMovieDetailsState = .failed(movieDetailsError)
                    } else {
                        fetchMovieDetailsState = .failed(.unknown)
                    }
                }
            }
        }
    }    
}
