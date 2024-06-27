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
    
    private var session: URLSessionProtocol = URLSession.shared

    func setSession(session: URLSessionProtocol) {
        self.session = session
    }
    
    func getRequestData<T: Decodable>(clearCache: Bool, components: URLComponents?, type: T.Type) async throws -> T {
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .useProtocolCachePolicy
        
        if clearCache {
            URLCache.shared.removeCachedResponse(for: request)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try JSONDecoder().decode(type, from: data)
        return decodedData
    }
}
