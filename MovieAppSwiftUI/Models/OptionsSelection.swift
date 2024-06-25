//
//  OptionsSelection.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import Foundation

enum OptionsSelection: String {
    case top = "Top Rated"
    case popular = "Popular"
    case trending = "Trending"
    case nowPlaying = "Now Playing"
    case upcoming = "Upcoming"
    case search
    
    var intValue: Int {
        switch self {
        case .top:
            return 0
        case .popular:
            return 1
        case .trending:
            return 2
        case .nowPlaying:
            return 3
        case .upcoming:
            return 4
        case .search:
            return 5
        }
    }
    
    init(intValue: Int) {
        switch intValue {
        case 0:
            self = .top
        case 1:
            self = .popular
        case 2:
            self = .trending
        case 3:
            self = .nowPlaying
        case 4:
            self = .upcoming
        default:
            self = .search
        }
    }
    
    init(_ rawValue: String) {
        switch rawValue {
        case "Top":
            self = .top
        case "Popular":
            self = .popular
        case "Trending":
            self = .trending
        case "Now Playing":
            self = .nowPlaying
        case "Upcoming":
            self = .upcoming
        default:
            self = .search
        }
    }
}

