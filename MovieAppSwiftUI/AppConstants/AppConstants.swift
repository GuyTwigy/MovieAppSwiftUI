//
//  AppConstants.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import Foundation

struct AppConstant {
    
    enum EndPoints {
        case search
        case movie
        case video
        case topRated
        case popular
        case trending
        case week
        case nowPlaying
        case upcoming
        
        var description: String {
            switch self {
            case .search:
                return "/search"
            case .movie:
                return "/movie"
            case .video:
                return "/videos"
            case .topRated:
                return "/top_rated"
            case .popular:
                return "/popular"
            case .trending:
                return "/trending"
            case .week:
                return "/week"
            case .nowPlaying:
                return "/now_playing"
            case .upcoming:
                return "/upcoming"
            }
        }
    }
    
    struct UserDefualtsKey {
        static let lastFetchedSuggestedMoviesDate: String = "lastFetchedSuggestedMoviesDate"
        static let lastFetchedTopMoviesDate: String = "lastFetchedTopMoviesDate"
        static let lastFetchedPopularMoviesDate: String = "lastFetchedPopularMoviesDate"
        static let lastFetchedTrendingMoviesDate: String = "lastFetchedTrendingMoviesDate"
        static let lastFetchedNowPlayingMoviesDate: String = "lastFetchedNowPlayingMoviesDate"
        static let lastFetchedUpcomingMoviesDate: String = "lastFetchedUpcomingMoviesDate"
    }
}
