//
//  MovieDetailsViewModelTests.swift
//  MovieDatabaseTests
//
//  Created by Jay Son on 2024-03-14.
//

import Combine
import XCTest
@testable import MovieDatabase

class MovieDetailsViewModelTests: XCTestCase {
    var viewModel: MovieDetailsViewModel!
    var mockRepository: MockMovieRepository!

    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        viewModel = MovieDetailsViewModel(title: "Test Movie", movieId: 1, repository: mockRepository)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        mockRepository = nil
    }
    
    func testInitializer_shouldSetOperationStateAsReady() {
        // then
        XCTAssertEqual(viewModel.fetchMovieDetailsState, .ready)
        XCTAssertNil(viewModel.movieDetails)
    }

    func testFetchMovieDetails_whenStarted_shouldSetOperationStateAsInProgress() {
        // given
        mockRepository.fetchMovieDetailsResult = .failure(.unknown)

        // when
        viewModel.fetchMovieDetails()

        // then
        XCTAssertEqual(viewModel.fetchMovieDetailsState, .inProgress)
    }

    func testFetchMovieDetails_whenLoadingSuccessfully_shouldSetOperationStateAsSucceeded() {
        // given
        let exp = expectation(description: "fetch movie details success")
        let fakeMovieDetails = MovieDetails(
            backdropPath: nil,
            genres: [],
            id: 1,
            originalTitle: "Test Movie",
            overview: "A test movie.",
            posterPath: nil,
            releaseDate: "2024-01-01",
            runtime: 120,
            title: "Test Movie",
            voteAverage: 8.0,
            credits: Credits(cast: []),
            similar: SimilarMovies(page: 1, results: [], totalPages: 0, totalResults: 0)
        )
        mockRepository.fetchMovieDetailsResult = .success(fakeMovieDetails)
        viewModel.$fetchMovieDetailsState
            .sink { newState in
                if case .succeeded = newState {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)

        // when
        viewModel.fetchMovieDetails()

        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.viewModel.fetchMovieDetailsState, .succeeded)
            XCTAssertEqual(self.viewModel.movieDetails, fakeMovieDetails)
            XCTAssertEqual(self.mockRepository.fetchMovieDetailsCallCount, 1)
        }
    }

    func testFetchMovieDetails_whenFailingToLoad_shouldSetOperationStateAsFailed() {
        // given
        let exp = expectation(description: "fetch movie details failure")
        let fakeErrorMessage = "Error fetching movie details"
        let fakeError = FetchMovieDataError.badResponse(fakeErrorMessage)
        mockRepository.fetchMovieDetailsResult = .failure(fakeError)
        var errorReceived: FetchMovieDataError?
        viewModel.$fetchMovieDetailsState
            .sink { newState in
                switch newState {
                case .failed(let error):
                    errorReceived = error
                    exp.fulfill()
                default:
                    break
                }
            }
            .store(in: &cancellables)

        // when
        viewModel.fetchMovieDetails()

        // then
        waitForExpectations(timeout: 1) { error in
            XCTAssertEqual(self.viewModel.fetchMovieDetailsState, .failed(fakeError))
            XCTAssertNotNil(errorReceived)
            switch errorReceived {
            case .badResponse(let message):
                XCTAssertEqual(message, fakeErrorMessage)
            default:
                XCTFail("Expected failure with .badResponse, got \(String(describing: errorReceived))")
            }
            XCTAssertEqual(self.mockRepository.fetchMovieDetailsCallCount, 1)
        }
    }
}
