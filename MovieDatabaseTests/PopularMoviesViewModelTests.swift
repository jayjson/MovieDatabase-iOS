//
//  PopularMoviesViewModelTests.swift
//  MovieDatabaseTests
//
//  Created by Jay Son on 2024-03-14.
//

import Combine
import XCTest
@testable import MovieDatabase

class PopularMoviesViewModelTests: XCTestCase {
    var viewModel: PopularMoviesViewModel!
    var mockRepository: MockMovieRepository!

    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        viewModel = PopularMoviesViewModel(repository: mockRepository)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        mockRepository = nil
    }
    
    func testInitializer_shouldSetOperationStateAsReady() {
        // then
        XCTAssertEqual(viewModel.fetchPopularMoviesState, .ready)
        XCTAssertTrue(viewModel.popularMovies.isEmpty)
    }

    func testFetchPopularMovies_whenStarted_shouldSetOperationStateAsInProgress() {
        // given
        let emptyResponse = PopularMoviesResponse(page: 1, results: [], totalPages: 1, totalResults: 0)
        mockRepository.fetchPopularMoviesResult = .success(emptyResponse)
        
        // when
        viewModel.fetchPopularMovies()

        // then
        XCTAssertEqual(viewModel.fetchPopularMoviesState, .inProgress)
    }
    
    func testFetchPopularMovies_whenCalledFetchConsecutively_shouldCallFetchPopularMoviesOnce() {
        // given
        let exp = expectation(description: "call fetch multiple times")
        let emptyResponse = PopularMoviesResponse(page: 1, results: [], totalPages: 1, totalResults: 0)
        mockRepository.fetchPopularMoviesResult = .success(emptyResponse)
        viewModel.$fetchPopularMoviesState
            .sink { newState in
                switch newState {
                case .succeeded:
                    exp.fulfill()
                default:
                    break
                }
            }
            .store(in: &cancellables)
        
        // when
        for _ in 0..<3 {
            viewModel.fetchPopularMovies()
        }
        
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.viewModel.fetchPopularMoviesState, .succeeded)
            XCTAssertEqual(self.mockRepository.fetchPopularMoviesCallCount, 1)
        }
    }

    func testFetchPopularMovies_whenLoadingSuccessfully_shouldSetOperationStateAsSuceeded() {
        // given
        let exp = expectation(description: "fetch popular movies succeess")
        let fakeMovie = PopularMovie(adult: false, backdropPath: nil, genreIds: [], id: 1, originalLanguage: "EN", originalTitle: "Hello", overview: "Hello world.", popularity: 9.9, releaseDate: "2024", title: "Hello", video: false, voteAverage: 7, voteCount: 1)
        let movies = [fakeMovie]
        let fakeResponse = PopularMoviesResponse(page: 1, results: movies, totalPages: 1, totalResults: 1)
        mockRepository.fetchPopularMoviesResult = .success(fakeResponse)
        viewModel.$fetchPopularMoviesState
            .sink { newState in
                switch newState {
                case .succeeded:
                    exp.fulfill()
                default:
                    break
                }
            }
            .store(in: &cancellables)

        // when
        viewModel.fetchPopularMovies()
                
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.viewModel.fetchPopularMoviesState, .succeeded)
            XCTAssertEqual(self.viewModel.popularMovies, movies)
            XCTAssertEqual(self.mockRepository.fetchPopularMoviesCallCount, 1)
        }
    }

    func testFetchPopularMovies_whenFailingToLoad_shouldSetOperationStateAsFailed() {
        // given
        let exp = expectation(description: "fetch popular movies failure")
        let fakeErrorMessage = "Error fetching movies"
        mockRepository.fetchPopularMoviesResult = .failure(.badResponse(fakeErrorMessage))
        var errorReceived: FetchMovieDataError?
        viewModel.$fetchPopularMoviesState
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
        viewModel.fetchPopularMovies()
                
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.viewModel.fetchPopularMoviesState, .failed(.badResponse("Error fetching movies")))
            XCTAssertNotNil(errorReceived)
            switch errorReceived {
            case .badResponse(let message):
                XCTAssertEqual(message, fakeErrorMessage)
            default:
                XCTFail("Expected failure with .badResponse, got \(String(describing: errorReceived))")
            }
            XCTAssertEqual(self.mockRepository.fetchPopularMoviesCallCount, 1)
        }
    }
}
