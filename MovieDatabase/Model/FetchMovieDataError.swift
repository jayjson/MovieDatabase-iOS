//
//  FetchMovieDataError.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-13.
//

import Foundation

enum FetchMovieDataError: Error, Equatable {
    case apiKeyMissing
    case invalidUrl
    case couldNotPerform
    case noInternetConnection
    case timeout
    case badResponse(String)
    case decodeError
    case unknown
    
    var userFriendlyDescription: String {
        switch self {
        case .apiKeyMissing:
            return "Add an API key in MovieDatabaseApp.swift"
        case .invalidUrl:
            return "An invalid URL was used."
        case .couldNotPerform:
            return "Failed to perform the networking function."
        case .noInternetConnection:
            return "No internet connection."
        case .timeout:
            return "Timeout."
        case .badResponse(let reason):
            return "A bad response was received. Reason: \(reason)"
        case .decodeError:
            return "The return data could not be decoded."
        case .unknown:
            return "An unknown error occured."
        }
    }
}
