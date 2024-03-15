//
//  MoviesRepositoryImpl.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-13.
//

import Foundation

class MovieRepositoryImpl: MovieRepository {
    static func popularMoviesUrlString(page: Int) -> String {
        "https://api.themoviedb.org/3/movie/popular?language=en-US&page=\(page)"
    }
    static func movieDetailsUrlString(with id: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)?append_to_response=credits%2Csimilar&language=en-US"
    }
    
    private lazy var headers = [
      "accept": "application/json",
      "Authorization": "Bearer \(apiKey)"
    ]
    
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchPopularMovies(page: Int) async throws -> PopularMoviesResponse {
        let urlString = MovieRepositoryImpl.popularMoviesUrlString(page: page)
        return try await performRequest(urlString: urlString)
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieDetails {
        let urlString = MovieRepositoryImpl.movieDetailsUrlString(with: id)
        return try await performRequest(urlString: urlString)
    }
    
    private func performRequest<T: Decodable>(urlString: String) async throws -> T {
        guard apiKey.isEmpty == false else {
            throw FetchMovieDataError.apiKeyMissing
        }
        guard let url = URL(string: urlString) else {
            throw FetchMovieDataError.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        let data: Data
        let urlResponse: URLResponse
        do {
            let result = try await URLSession.shared.data(for: urlRequest)
            data = result.0
            urlResponse = result.1
        } catch {
            guard let error = error as? URLError else { throw FetchMovieDataError.unknown }
            if error.code == .timedOut {
                throw FetchMovieDataError.timeout
            } else if error.code == .notConnectedToInternet {
                throw FetchMovieDataError.noInternetConnection
            } else {
                throw FetchMovieDataError.badResponse(error.localizedDescription)
            }
        }
        guard let response = urlResponse as? HTTPURLResponse else { throw FetchMovieDataError.unknown }
        guard response.statusCode == 200 else {
            throw FetchMovieDataError.badResponse("Received a \(response.statusCode) response.")
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let fetchedResponse = try? decoder.decode(T.self, from: data) else {
            throw FetchMovieDataError.decodeError
        }
        return fetchedResponse
    }
}
