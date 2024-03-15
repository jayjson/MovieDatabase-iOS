#  Movie Database App
## Overview
- This project contains an app that fetches and displays a list of popular movies from tmdbʼs API. The app uses SwifUI and the MVVM + Coordinator architectural pattern to support quick product iterations, and its core functionalities are covered by unit tests to prevent regressions.
- More info on tmdbʼs API (more info: https://developers.themoviedb.org/3/getting-started/introduction)

## What's Covered
### General / Across the App
- MVVM + Coordinator Design Pattern: To create a scalable and maintainable application, separating the business logic from the view layer.
- Repository Layer: For data management and network logic, providing an abstraction over data sources and ensuring a single source of truth.
- Protocol-Oriented Programming & Mock Objects: To increase the testability of the code and to maintain a high level of software quality.
- Unit Tests for View Models: To ensure application reliability and prevent regressions.
- Swift Concurrency: To fetch remote data, providing a more readable and safe way to write asynchronous code.
- Error Handling: To improve user experience and application reliability.

### Screen 1 (Popular Movies)
- Use of a lazy grid to disply movie posters and titles
- Pagination for fetching popular movies data
- Handling different scenarios related to fetching movies data and images
- Caching for offline support and faster load times
- User of a navigation stack to support multiple pushes
- Dynamic sizing of cells

### Screen 2 (Movie Details)
- Displaying movie details including title, backdrop image, cast images, and similar movies
- Displaying images while retaining original aspect ratios
- Support for navigating into similar movies

## How you run the project
- Open the Xcode project file in the root folder with Xcode 14.0+ and 
- Open the MovieDatabaseApp file and add a valid tmdb's API key into MovieCoordinator's initializer
- Run on iOS 16+

## 3rd party libraries or copied code you used
- Kingfisher for image loading (https://github.com/onevcat/Kingfisher)
