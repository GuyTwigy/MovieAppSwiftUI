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
        
        do {
            let movie = try await getRequestData(components: components, type: MovieData.self)
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

        do {
            let movieResponse = try await getRequestData(components: components, type: MoviesRoot.self)
            return movieResponse
        } catch {
            throw error
        }
    }
}
