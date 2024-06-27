//
//  MovieAppManager.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 27/06/2024.
//

import Foundation

class MovieAppManager {
    
    static let share: MovieAppManager = MovieAppManager()
    let defaults = UserDefaults.standard
    
    var lastFetchedSuggestedMoviesDate: Date? {
        get {
            if let date = defaults.value(forKey: AppConstant.UserDefualtsKey.lastFetchedSuggestedMoviesDate) as? Date {
                return date
            }
            return nil
        }
        set {
            defaults.setValue(newValue, forKey: AppConstant.UserDefualtsKey.lastFetchedSuggestedMoviesDate)
            defaults.synchronize()
        }
    }
    
    var lastFetchedTopMoviesDate: Date? {
        get {
            if let date = defaults.value(forKey: AppConstant.UserDefualtsKey.lastFetchedTopMoviesDate) as? Date {
                return date
            }
            return nil
        }
        set {
            defaults.setValue(newValue, forKey: AppConstant.UserDefualtsKey.lastFetchedTopMoviesDate)
            defaults.synchronize()
        }
    }
    
    var lastFetchedPopularMoviesDate: Date? {
        get {
            if let date = defaults.value(forKey: AppConstant.UserDefualtsKey.lastFetchedPopularMoviesDate) as? Date {
                return date
            }
            return nil
        }
        set {
            defaults.setValue(newValue, forKey: AppConstant.UserDefualtsKey.lastFetchedPopularMoviesDate)
            defaults.synchronize()
        }
    }
    
    var lastFetchedTrendingMoviesDate: Date? {
        get {
            if let date = defaults.value(forKey: AppConstant.UserDefualtsKey.lastFetchedTrendingMoviesDate) as? Date {
                return date
            }
            return nil
        }
        set {
            defaults.setValue(newValue, forKey: AppConstant.UserDefualtsKey.lastFetchedTrendingMoviesDate)
            defaults.synchronize()
        }
    }
    
    var lastFetchedNowPlayingMoviesDate: Date? {
        get {
            if let date = defaults.value(forKey: AppConstant.UserDefualtsKey.lastFetchedNowPlayingMoviesDate) as? Date {
                return date
            }
            return nil
        }
        set {
            defaults.setValue(newValue, forKey: AppConstant.UserDefualtsKey.lastFetchedNowPlayingMoviesDate)
            defaults.synchronize()
        }
    }
    
    var lastFetchedUpcomingMoviesDate: Date? {
        get {
            if let date = defaults.value(forKey: AppConstant.UserDefualtsKey.lastFetchedUpcomingMoviesDate) as? Date {
                return date
            }
            return nil
        }
        set {
            defaults.setValue(newValue, forKey: AppConstant.UserDefualtsKey.lastFetchedUpcomingMoviesDate)
            defaults.synchronize()
        }
    }
}
