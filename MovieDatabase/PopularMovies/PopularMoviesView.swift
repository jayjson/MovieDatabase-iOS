//
//  PopularMoviews.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-13.
//

import SwiftUI

struct PopularMoviesView: View {
    @ObservedObject var coordinator: MovieCoordinator
    @ObservedObject var viewModel: PopularMoviesViewModel
        
    private var columns: [GridItem] {
        return Array(
            repeating: GridItem(.fixed(columnWidth)),
            count: numberOfColumns
        )
    }
    
    private let numberOfColumns = 3

    private var columnWidth: CGFloat {
        let sideMargins = Constant.sideMargin * 2
        let interColumnSpacings = Constant.gridSpacingBetweenColumnsOrRows * CGFloat(numberOfColumns-1)
        return (Constant.screenSize.width - (sideMargins + interColumnSpacings)) / CGFloat(numberOfColumns)
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPaths) {
            ScrollView {
                moviesGrid
                Group {
                    switch viewModel.fetchPopularMoviesState {
                    case .ready, .succeeded:
                        Text("🍿 Movie Database")
                    case .inProgress:
                        ProgressView()
                    case .failed(let fetchError):
                        VStack {
                            Spacer()
                            Text(fetchError.userFriendlyDescription)
                                .multilineTextAlignment(.center)
                                .padding()
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Popular")
            .navigationDestination(for: NavigationPath.self) { path in
                coordinator.destinationView(for: path)
            }
        }
        .onAppear(perform: viewModel.fetchPopularMovies)
    }
    
    private var moviesGrid: some View {
        LazyVGrid(columns: columns, spacing: Constant.gridSpacingBetweenColumnsOrRows) {
            ForEach(viewModel.popularMovies, id: \.id) { movie in
                MovieCell(movie: movie, width: columnWidth) {
                    coordinator.navigate(to: .details(title: movie.title, id: movie.id))
                }
                .onAppear {
                    viewModel.fetchNextPageIfNeeded(movie: movie)
                }
            }
        }
        .padding()
    }
}

extension PopularMoviesView {
    enum Constant {
        static var screenSize: CGSize {
            guard let size = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen.bounds.size else { return .zero }
            return size
        }
        static let gridSpacingBetweenColumnsOrRows: CGFloat = 8
        static let sideMargin: CGFloat = 16
    }
}
