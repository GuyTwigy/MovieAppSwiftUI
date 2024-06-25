//
//  NetworkManager.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import Foundation

class NetworkManager {

    let baseUrl = "https://api.themoviedb.org/3"
    let apiKey = "ab0f464004f9fe46240dab71b2b89a08"
    
}

protocol FetchMoviesProtocol {
    func fetchMovies(optionSelected: OptionsSelection, query: String, page: Int) async throws -> MoviesRoot
    func fetchMultipleSuggestions(ids: [String]) async throws -> [MovieData]
}

extension NetworkManager: FetchMoviesProtocol {
    func fetchSingleSuggestion(id: String) async throws -> MovieData {
        let url = URL(string: "\(baseUrl)\(AppConstant.EndPoints.movie.description)/\(id)?api_key=\(apiKey)")
        guard let url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("max-age=86400", forHTTPHeaderField: "Cache-Control")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            try validateResponse(response)
            let movie = try JSONDecoder().decode(MovieData.self, from: data)
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
            components.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: String(page)),
            ]
        }
        
        if optionSelected != .search {
            components.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "page", value: String(page)),
            ]
        }
        
        do {
            let movieResponse = try await requestCallMovies(components: components)
            return movieResponse
        } catch {
            throw error
        }
    }
    
    func requestCallMovies(components: URLComponents) async throws -> MoviesRoot {
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("max-age=86400", forHTTPHeaderField: "Cache-Control")
        request.cachePolicy = .useProtocolCachePolicy
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            try validateResponse(response)
            let movieResponse = try JSONDecoder().decode(MoviesRoot.self, from: data)
            return movieResponse
        } catch {
            throw error
        }
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}

protocol GetTrailerProtocol {
    func getTrailer(id: String) async throws -> [VideoData]
}

extension NetworkManager: GetTrailerProtocol {
    func getTrailer(id: String) async throws -> [VideoData] {
        var components = URLComponents(string: "\(baseUrl)\(AppConstant.EndPoints.movie.description)/\(id)\(AppConstant.EndPoints.video.description)")
        
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("max-age=86400", forHTTPHeaderField: "Cache-Control")
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            let videoResponse = try JSONDecoder().decode(VideosResponse.self, from: data)
            return videoResponse.results
        } catch {
            throw error
        }
    }
}
