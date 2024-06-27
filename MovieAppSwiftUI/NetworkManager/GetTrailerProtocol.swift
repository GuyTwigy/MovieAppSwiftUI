//
//  GetTrailerProtocol.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 27/06/2024.
//

import Foundation

protocol GetTrailerProtocol {
    func getTrailer(id: String) async throws -> [VideoData]
}

extension NetworkManager: GetTrailerProtocol {
    func getTrailer(id: String) async throws -> [VideoData] {
        var components = URLComponents(string: "\(baseUrl)\(AppConstant.EndPoints.movie.description)/\(id)\(AppConstant.EndPoints.video.description)")
        
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        
        do {
            let videoResponse = try await getRequestData(clearCache: false, components: components, type: VideosResponse.self)
            return videoResponse.results
        } catch {
            throw error
        }
    }
}
