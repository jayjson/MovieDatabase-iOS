//
//  MovieDatabaseApp.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-13.
//

import SwiftUI

@main
struct MovieDatabaseApp: App {
    let coordinator = MovieCoordinator(apiKey: "") // "ADD API KEY HERE"
    
    var body: some Scene {
        WindowGroup {
            coordinator.makeInitialScreen()
        }
    }
}
