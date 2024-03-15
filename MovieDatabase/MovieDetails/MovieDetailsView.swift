//
//  MovieDetailsView.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-14.
//

import Kingfisher
import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var coordinator: MovieCoordinator
    @StateObject var viewModel: MovieDetailsViewModel
    
//    var body: some View {
//        ScrollView {
//            if let movieDetails = viewModel.movieDetails {
//                movieDetailSections(with: movieDetails)
//            }
//            Group {
//                switch viewModel.fetchMovieDetailsState {
//                case .ready, .succeeded:
//                    Text("🍿 Movie Database")
//                case .inProgress:
//                    VStack {
//                        Spacer()
//                        ProgressView()
//                        Spacer()
//                    }
//                case .failed(let fetchError):
//                    VStack {
//                        Spacer()
//                        Text(fetchError.userFriendlyDescription)
//                            .multilineTextAlignment(.center)
//                            .padding()
//                        Spacer()
//                    }
//                }
//            }
//
//        }
//        .navigationTitle(viewModel.title)
//        .navigationBarTitleDisplayMode(.inline)
//    }
    
    var body: some View {
        Group {
            switch viewModel.fetchMovieDetailsState {
            case .ready:
                VStack {
                    Spacer()
                    Text("🍿 Movie Database")
                    Spacer()
                }
            case .inProgress:
                ProgressView()
            case .succeeded:
                ScrollView {
                    if let movieDetails = viewModel.movieDetails {
                        movieDetailSections(with: movieDetails)
                    }
                }
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
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: viewModel.fetchMovieDetails)
    }
    
    private func movieDetailSections(with movieDetails: MovieDetails) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                coverImageSection(with: movieDetails)
                descriptionSection(with: movieDetails)
                overviewSection(with: movieDetails)
                castSection(with: movieDetails.credits.cast)
                if !movieDetails.similar.results.isEmpty {
                    similarMoviesSection(with: movieDetails)
                }
            }
        }
    }
    
    private func coverImageSection(with movieDetails: MovieDetails) -> some View {
        KFImage(movieDetails.backdropImageUrl)
            .cacheOriginalImage()
            .cancelOnDisappear(true)
            .onFailureImage(fallbackImage)
            .placeholder {
                ProgressView()
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200)
            .padding(.horizontal)
    }
    
    private var fallbackImage: UIImage? {
        guard let image = UIImage(systemName: "popcorn", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light)) else { return nil }
        return image.imageWithInsets(insets: .init(top: 40, left: 80, bottom: 40, right: 80))
    }
    
    private func descriptionSection(with movieDetails: MovieDetails) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 16) {
                    Text(movieDetails.title)
                        .font(.title)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(movieDetails.genres.map { $0.name }.joined(separator: ", "))
                        Text("Rating: \(movieDetails.ratingText)")
                        if let runtime = movieDetails.runtime {
                            Text("Runtime: \(runtime) minutes")
                        }
                        Text("Release Date: \(movieDetails.releaseDate)")
                    }
                }
                Spacer()
                KFImage(movieDetails.posterImageUrl)
                    .cacheOriginalImage()
                    .cancelOnDisappear(true)
                    .onFailureImage(fallbackImage)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
            }
        }
        .padding(.horizontal)
    }
    
    private func overviewSection(with movieDetails: MovieDetails) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overview")
                .font(.headline)
            Text(movieDetails.overview)
        }
        .padding(.horizontal)
    }
    
    private func castSection(with cast: [CastMember]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Cast")
                .font(.headline)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(cast, id: \.id) { castMember in
                        ActorCell(castMember: castMember) {
                            print("actor \(castMember.name) tapped")
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func similarMoviesSection(with movieDetails: MovieDetails) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Similar Movies")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(movieDetails.similar.results, id: \.id) { movie in
                        MovieCell(movie: movie) {
                            coordinator.navigate(to: .details(title: movie.title, id: movie.id))
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

//#Preview {
//    MovieDetails()
//}
