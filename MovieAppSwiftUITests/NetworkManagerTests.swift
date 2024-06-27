//
//  NetworkManagerTests.swift
//  MovieAppSwiftUITests
//
//  Created by Guy Twig on 27/06/2024.
//

import XCTest
@testable import MovieAppSwiftUI

final class NetworkManagerTests: XCTestCase {
    
    var dataService: NetworkManager?
    
    override func setUpWithError() throws {
        dataService = NetworkManager()
    }
    
    override func tearDownWithError() throws {
        dataService = nil
    }
    
    
    func test_NetworkManager_fetchSingleSuggestionSuccess() async throws {
        // Given
        let id = "1817"
        
        // When
        let expectation = self.expectation(description: "Fetch Single Suggestion with Success")
        do {
            let movie = try await dataService?.fetchSingleSuggestion(id: id)
            expectation.fulfill()
            
            //Then
            XCTAssertNotNil(movie)
            XCTAssertEqual(movie?.id, Int(id))
            XCTAssertEqual(movie?.title, "Phone Booth")
        } catch {
            XCTFail()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0, enforceOrder: true)
    }
    
    func test_NetworkManager_fetchMultipleSuggestionsSuccess() async throws {
        // Given
        let ids: [String] = ["1817", "745", "769", "278", "429"]
        
        // When
        let expectation = self.expectation(description: "Fetch Multiple Suggestion with Success")
        do {
            let movies = try await dataService?.fetchMultipleSuggestions(ids: ids)
            expectation.fulfill()
            
            //Then
            XCTAssertNotNil(movies)
            XCTAssertFalse(movies?.isEmpty ?? true)
            XCTAssertEqual(movies?.count, 5)
            XCTAssertTrue(ids.contains( where: { $0 == "\(movies?[0].id ?? 1)" }))
            XCTAssertTrue(ids.contains( where: { $0 == "\(movies?[1].id ?? 1)" }))
            XCTAssertTrue(ids.contains( where: { $0 == "\(movies?[2].id ?? 1)" }))
            XCTAssertTrue(ids.contains( where: { $0 == "\(movies?[3].id ?? 1)" }))
            XCTAssertTrue(ids.contains( where: { $0 == "\(movies?[4].id ?? 1)" }))
        } catch {
            XCTFail()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0, enforceOrder: true)
    }
    
    func test_NetworkManager_fetchMoviesTypeTopSuccess() async throws {
        // Given
        //Given
        let optionSelection: OptionsSelection = .top
        let query = ""
        let page = 1
        
        // When
        let expectation = self.expectation(description: "Fetch Movies type Top with Success")
        do {
            let movieRoot = try await dataService?.fetchMovies(optionSelected: optionSelection, query: query, page: page)
            expectation.fulfill()
            
            //Then
            XCTAssertNotNil(movieRoot?.results)
            XCTAssertFalse(movieRoot?.results?.isEmpty ?? true)
            XCTAssertGreaterThan(movieRoot?.results?.count ?? 0, 8)
            XCTAssertEqual(movieRoot?.results?.count ?? 0, 20)
        } catch {
            XCTFail()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0, enforceOrder: true)
    }
    
    func test_NetworkManager_fetchMoviesTypePopularSuccess() async throws {
        // Given
        //Given
        let optionSelection: OptionsSelection = .popular
        let query = ""
        let page = 1
        
        // When
        let expectation = self.expectation(description: "Fetch Movies type Popular with Success")
        do {
            let movieRoot = try await dataService?.fetchMovies(optionSelected: optionSelection, query: query, page: page)
            expectation.fulfill()
            
            //Then
            XCTAssertNotNil(movieRoot?.results)
            XCTAssertFalse(movieRoot?.results?.isEmpty ?? true)
            XCTAssertGreaterThan(movieRoot?.results?.count ?? 0, 8)
            XCTAssertEqual(movieRoot?.results?.count ?? 0, 20)
        } catch {
            XCTFail()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0, enforceOrder: true)
    }
    
    func test_NetworkManager_fetchMoviesTypeTrendingSuccess() async throws {
        // Given
        //Given
        let optionSelection: OptionsSelection = .trending
        let query = ""
        let page = 1
        
        // When
        let expectation = self.expectation(description: "Fetch Movies type Trending with Success")
        do {
            let movieRoot = try await dataService?.fetchMovies(optionSelected: optionSelection, query: query, page: page)
            expectation.fulfill()
            
            //Then
            XCTAssertNotNil(movieRoot?.results)
            XCTAssertFalse(movieRoot?.results?.isEmpty ?? true)
            XCTAssertGreaterThan(movieRoot?.results?.count ?? 0, 8)
            XCTAssertEqual(movieRoot?.results?.count ?? 0, 20)
        } catch {
            XCTFail()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0, enforceOrder: true)
    }
    
    func test_NetworkManager_fetchMoviesTypeUpcomingSuccess() async throws {
        // Given
        //Given
        let optionSelection: OptionsSelection = .upcoming
        let query = ""
        let page = 1
        
        // When
        let expectation = self.expectation(description: "Fetch Movies type Upcoming with Success")
        do {
            let movieRoot = try await dataService?.fetchMovies(optionSelected: optionSelection, query: query, page: page)
            expectation.fulfill()
            
            //Then
            XCTAssertNotNil(movieRoot?.results)
            XCTAssertFalse(movieRoot?.results?.isEmpty ?? true)
            XCTAssertGreaterThan(movieRoot?.results?.count ?? 0, 8)
            XCTAssertEqual(movieRoot?.results?.count ?? 0, 20)
        } catch {
            XCTFail()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0, enforceOrder: true)
    }
    
    func test_NetworkManager_fetchMoviesTypeNowPalyingSuccess() async throws {
        // Given
        //Given
        let optionSelection: OptionsSelection = .nowPlaying
        let query = ""
        let page = 1
        
        // When
        let expectation = self.expectation(description: "Fetch Movies type NowPalying with Success")
        do {
            let movieRoot = try await dataService?.fetchMovies(optionSelected: optionSelection, query: query, page: page)
            expectation.fulfill()
            
            //Then
            XCTAssertNotNil(movieRoot?.results)
            XCTAssertFalse(movieRoot?.results?.isEmpty ?? true)
            XCTAssertGreaterThan(movieRoot?.results?.count ?? 0, 8)
            XCTAssertEqual(movieRoot?.results?.count ?? 0, 20)
        } catch {
            XCTFail()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0, enforceOrder: true)
    }
    
    func test_NetworkManager_fetchMoviesTypeSearchSuccess() async throws {
        // Given
        //Given
        let optionSelection: OptionsSelection = .search
        let query = "messi"
        let page = 1
        
        // When
        let expectation = self.expectation(description: "Fetch Movies type Search with Success")
        do {
            let movieRoot = try await dataService?.fetchMovies(optionSelected: optionSelection, query: query, page: page)
            expectation.fulfill()
            
            //Then
            XCTAssertNotNil(movieRoot?.results)
            XCTAssertFalse(movieRoot?.results?.isEmpty ?? true)
            XCTAssertGreaterThan(movieRoot?.results?.count ?? 0, 8)
            XCTAssertEqual(movieRoot?.results?.count ?? 0, 20)
        } catch {
            XCTFail()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0, enforceOrder: true)
    }
}
