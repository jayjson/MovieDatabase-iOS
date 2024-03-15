//
//  MovieProtocol.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-14.
//

import Foundation

protocol MovieProtocol {
    var title: String { get }
    var posterImageUrl: URL? { get }
}
