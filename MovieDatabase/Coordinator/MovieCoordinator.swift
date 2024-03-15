//
//  MovieCoordinator.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-14.
//

import SwiftUI

final class MovieCoordinator: ObservableObject {
    @Published var navigationPaths = [NavigationPath]()
    
    private let repository: MovieRepository
    
    init(apiKey: String) {
        repository = MovieRepositoryImpl(apiKey: apiKey)
    }
    
    func makeInitialScreen() -> some View {
        Group {
            let viewModel = PopularMoviesViewModel(repository: repository)
            PopularMoviesView(coordinator: self, viewModel: viewModel)
        }
    }
    
    func navigate(to path: NavigationPath) {
        navigationPaths.append(path)
    }
    
    func destinationView(for path: NavigationPath) -> some View {
        Group {
            switch path {
            case .details(let title, let id):
                let viewModel = MovieDetailsViewModel(title: title, movieId: id, repository: repository)
                MovieDetailsView(coordinator: self, viewModel: viewModel)
            }
        }
    }
}
