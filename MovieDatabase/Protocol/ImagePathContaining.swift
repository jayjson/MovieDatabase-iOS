//
//  ImagePathContaining.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-14.
//

import Foundation

protocol ImagePathContaining {}

extension ImagePathContaining {
    func makeImageUrl(imagePath: String, sizePath: String) -> URL? {
        let secureBaseUrl =  "https://image.tmdb.org/t/p/"
        guard var urlComponents = URLComponents(string: secureBaseUrl) else { return nil }
        urlComponents.path += (sizePath + imagePath)
        return urlComponents.url
    }
}
