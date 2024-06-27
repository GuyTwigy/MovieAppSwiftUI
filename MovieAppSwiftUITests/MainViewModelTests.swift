//
//  MainViewModelTests.swift
//  MovieAppSwiftUITests
//
//  Created by Guy Twig on 27/06/2024.
//

import XCTest
@testable import MovieAppSwiftUI

@MainActor
class MainViewModelTests: XCTestCase {
    var vm: MainViewModel!
    
    override func setUpWithError() throws {
        vm = MainViewModel()
    }
    
    override func tearDownWithError() throws {
        vm = nil
    }
    
    func test_MainViewModel_fetchSuggestionsSuccess() async throws {
        //Given
        let ids: [String] = ["1817", "745", "769", "278", "429"]
        
        //When
        await vm.fetchSuggestions()
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            XCTAssertFalse(vm.suggestedError)
            XCTAssertFalse(vm.suggestionIsLoading)
            XCTAssertEqual(vm.suggestedMovies.count, 5)
            XCTAssertTrue(ids.contains( where: { $0 == "\(self.vm.suggestedMovies[0].id ?? 1)" }))
            XCTAssertTrue(ids.contains( where: { $0 == "\(self.vm.suggestedMovies[1].id ?? 1)" }))
            XCTAssertTrue(ids.contains( where: { $0 == "\(self.vm.suggestedMovies[2].id ?? 1)" }))
            XCTAssertTrue(ids.contains( where: { $0 == "\(self.vm.suggestedMovies[3].id ?? 1)" }))
            XCTAssertTrue(ids.contains( where: { $0 == "\(self.vm.suggestedMovies[4].id ?? 1)" }))
        }
    }
    
    func test_MainViewModel_fetchMoviesSuccessAddContentFalseTop() async throws {
        //Given
        let optionSelection: OptionsSelection = .top
        let query = ""
        let page = 1
        let addContent = false
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: addContent)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 8)
            XCTAssertEqual(self.vm.moviesList.count, 20)
        }
    }

    func test_MainViewModel_fetchMoviesSuccessAddContentTrueTop() async throws {
        //Given
        let optionSelection: OptionsSelection = .top
        let query = ""
        let page = 1
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: false)
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page + 1, addContent: true)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 20)
            XCTAssertEqual(self.vm.moviesList.count, 40)
        }
    }
    
    func test_MainViewModel_fetchMoviesSuccessAddContentFalseTrending() async throws {
        //Given
        let optionSelection: OptionsSelection = .trending
        let query = ""
        let page = 1
        let addContent = false
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: addContent)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 8)
            XCTAssertEqual(self.vm.moviesList.count, 20)
        }
    }

    func test_MainViewModel_fetchMoviesSuccessAddContentTrueTrending() async throws {
        //Given
        let optionSelection: OptionsSelection = .trending
        let query = ""
        let page = 1
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: false)
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page + 1, addContent: true)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 20)
            XCTAssertEqual(self.vm.moviesList.count, 40)
        }
    }
    
    func test_MainViewModel_fetchMoviesSuccessAddContentFalsePopular() async throws {
        //Given
        let optionSelection: OptionsSelection = .popular
        let query = ""
        let page = 1
        let addContent = false
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: addContent)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 8)
            XCTAssertEqual(self.vm.moviesList.count, 20)
        }
    }

    func test_MainViewModel_fetchMoviesSuccessAddContentTruePopular() async throws {
        //Given
        let optionSelection: OptionsSelection = .popular
        let query = ""
        let page = 1
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: false)
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page + 1, addContent: true)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 20)
            XCTAssertEqual(self.vm.moviesList.count, 40)
        }
    }
    
    func test_MainViewModel_fetchMoviesSuccessAddContentFalseNowPlaying() async throws {
        //Given
        let optionSelection: OptionsSelection = .nowPlaying
        let query = ""
        let page = 1
        let addContent = false
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: addContent)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 8)
            XCTAssertEqual(self.vm.moviesList.count, 20)
        }
    }

    func test_MainViewModel_fetchMoviesSuccessAddContentTrueNowPlaying() async throws {
        //Given
        let optionSelection: OptionsSelection = .nowPlaying
        let query = ""
        let page = 1
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: false)
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page + 1, addContent: true)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 20)
            XCTAssertEqual(self.vm.moviesList.count, 40)
        }
    }
    
    func test_MainViewModel_fetchMoviesSuccessAddContentFalseUpcoming() async throws {
        //Given
        let optionSelection: OptionsSelection = .upcoming
        let query = ""
        let page = 1
        let addContent = false
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: addContent)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 8)
            XCTAssertEqual(self.vm.moviesList.count, 20)
        }
    }

    func test_MainViewModel_fetchMoviesSuccessAddContentTrueUpcoming() async throws {
        //Given
        let optionSelection: OptionsSelection = .upcoming
        let query = ""
        let page = 1
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: false)
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page + 1, addContent: true)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 20)
            XCTAssertEqual(self.vm.moviesList.count, 40)
        }
    }
    
    func test_MainViewModel_fetchMoviesSuccessAddContentFalseSearch() async throws {
        //Given
        let optionSelection: OptionsSelection = .search
        let query = ""
        let page = 1
        let addContent = false
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: addContent)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 8)
            XCTAssertEqual(self.vm.moviesList.count, 20)
        }
    }

    func test_MainViewModel_fetchMoviesSuccessAddContentTrueSearch() async throws {
        //Given
        let optionSelection: OptionsSelection = .search
        let query = "messi"
        let page = 1
        
        //when
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page, addContent: false)
        await vm.fetchMovies(optionSelection: optionSelection, query: query, page: page + 1, addContent: true)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self else {
                XCTFail()
                return
            }
            
            XCTAssertFalse(self.vm.fetchingError)
            XCTAssertNotNil(self.vm.movieRoot)
            XCTAssertFalse(self.vm.moviesList.isEmpty)
            XCTAssertGreaterThan(self.vm.moviesList.count, 20)
            XCTAssertEqual(self.vm.moviesList.count, 40)
        }
    }
}
