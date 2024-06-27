//
//  FetchMoviesProtocol.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 27/06/2024.
//

import Foundation

protocol FetchMoviesProtocol {
    func fetchMovies(optionSelected: OptionsSelection, query: String, page: Int) async throws -> MoviesRoot
    func fetchMultipleSuggestions(ids: [String]) async throws -> [MovieData]
    func fetchSingleSuggestion(id: String) async throws -> MovieData
}

extension NetworkManager: FetchMoviesProtocol {
    func fetchSingleSuggestion(id: String) async throws -> MovieData {
        let components = URLComponents(string: "\(baseUrl)\(AppConstant.EndPoints.movie.description)/\(id)?api_key=\(apiKey)") ?? URLComponents()
        
        var clearCache = MovieAppManager.share.lastFetchedSuggestedMoviesDate ?? Date() < Utils.dateBeforeNow(seconds: 86400)
        MovieAppManager.share.lastFetchedSuggestedMoviesDate = Date()
        
        do {
            let movie = try await getRequestData(clearCache: clearCache, components: components, type: MovieData.self)
            return movie
        } catch {
            throw error
        }
    }
    
    func fetchMultipleSuggestions(ids: [String]) async throws -> [MovieData] {
        try await withThrowingTaskGroup(of: MovieData.self) { group in
            var movies: [MovieData] = []
            
            for id in ids {
                group.addTask { [weak self] in
                    guard let self else {
                        throw URLError(.badServerResponse)
                    }
                    
                    return try await self.fetchSingleSuggestion(id: id)
                }
            }
            
            for try await movie in group {
                movies.append(movie)
            }
            
            return movies
        }
    }
    
    func fetchMovies(optionSelected: OptionsSelection, query: String = "", page: Int = 1) async throws -> MoviesRoot {
        var components = createURLComponents(optionSelected: optionSelected, query: query, page: page)
        var clearCache = shouldClearCache(optionSelected: optionSelected)
        
        do {
            let movieResponse = try await getRequestData(clearCache: clearCache, components: components, type: MoviesRoot.self)
            return movieResponse
        } catch {
            throw error
        }
    }
    
    func createURLComponents(optionSelected: OptionsSelection, query: String = "", page: Int = 1) -> URLComponents {
        var components = URLComponents()

        switch optionSelected {
        case .top:
            components = URLComponents(string: "\(baseUrl)\(AppConstant.EndPoints.movie.description)\(AppConstant.EndPoints.topRated.description)") ?? URLComponents()
        case .popular:
            components = URLComponents(string: "\(baseUrl)\(AppConstant.EndPoints.movie.description)\(AppConstant.EndPoints.popular.description)") ?? URLComponents()
        case .trending:
            components = URLComponents(string: "\(baseUrl)\(AppConstant.EndPoints.trending.description)\(AppConstant.EndPoints.movie.description)\(AppConstant.EndPoints.week.description)") ?? URLComponents()
        case .nowPlaying:
            components = URLComponents(string: "\(baseUrl)\(AppConstant.EndPoints.movie.description)\(AppConstant.EndPoints.nowPlaying.description)") ?? URLComponents()
        case .upcoming:
            components = URLComponents(string: "\(baseUrl)\(AppConstant.EndPoints.movie.description)\(AppConstant.EndPoints.upcoming.description)") ?? URLComponents()
        case .search:
            components = URLComponents(string: "\(baseUrl)\(AppConstant.EndPoints.search.description)\(AppConstant.EndPoints.movie.description)") ?? URLComponents()
        }
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "page", value: String(page))
        ]
        if optionSelected == .search {
            components.queryItems?.append(URLQueryItem(name: "query", value: query))
        }
        
        return components
    }
    
    func shouldClearCache(optionSelected: OptionsSelection) -> Bool {
        var clearCache: Bool = false
        switch optionSelected {
        case .top:
            clearCache = MovieAppManager.share.lastFetchedTopMoviesDate ?? Date() < Utils.dateBeforeNow(seconds: 86400)
            MovieAppManager.share.lastFetchedTopMoviesDate = Date()
        case .popular:
            clearCache = MovieAppManager.share.lastFetchedPopularMoviesDate ?? Date() < Utils.dateBeforeNow(seconds: 86400)
            MovieAppManager.share.lastFetchedPopularMoviesDate = Date()
        case .trending:
            clearCache = MovieAppManager.share.lastFetchedTrendingMoviesDate ?? Date() < Utils.dateBeforeNow(seconds: 86400)
            MovieAppManager.share.lastFetchedTrendingMoviesDate = Date()
        case .nowPlaying:
            clearCache = MovieAppManager.share.lastFetchedNowPlayingMoviesDate ?? Date() < Utils.dateBeforeNow(seconds: 86400)
            MovieAppManager.share.lastFetchedNowPlayingMoviesDate = Date()
        case .upcoming:
            clearCache = MovieAppManager.share.lastFetchedUpcomingMoviesDate ?? Date() < Utils.dateBeforeNow(seconds: 86400)
            MovieAppManager.share.lastFetchedUpcomingMoviesDate = Date()
        case .search:
            clearCache = true
        }
        return clearCache
    }
}
