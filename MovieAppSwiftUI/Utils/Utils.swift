//
//  Utils.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import Foundation

class Utils {
    
    static func getImageUrl(posterPath: String, size: String = "original") -> URL? {
        let fullPath = "https://image.tmdb.org/t/p/\(size)\(posterPath)"
        return URL(string: fullPath)
    }
    
    static func isDataOlderThanOneDay(for date: Date?) -> Bool {
        guard let date else {
            return false
        }
        
        return Date().timeIntervalSince(date) > 24 * 60 * 60
    }
}
