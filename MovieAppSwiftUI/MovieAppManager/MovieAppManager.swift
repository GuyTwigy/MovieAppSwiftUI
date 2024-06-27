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
    
    var lastFetchedDate: Date? {
        get {
            if let date = defaults.value(forKey: AppConstant.UserDefualtsKey.lastFetchedDate) as? Date {
                return date
            }
            return nil
        }
        set {
            defaults.setValue(newValue, forKey: AppConstant.UserDefualtsKey.lastFetchedDate)
            defaults.synchronize()
        }
    }
}
