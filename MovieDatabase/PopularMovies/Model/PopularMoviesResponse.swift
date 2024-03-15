//
//  PopularMoviesResponse.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-13.
//

import Foundation

struct PopularMoviesResponse: Decodable {
    let page: Int
    let results: [PopularMovie]
    let totalPages: Int
    let totalResults: Int
}
