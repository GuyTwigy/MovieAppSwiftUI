//
//  MainViewModel.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var suggestedMovies: [MovieData] = []
    @Published var moviesList: [MovieData] = []
    var dataService = NetworkManager()
    
    init() {
        Task {
            await fetchSuggestions()
        }
    }
    
    func fetchSuggestions() async {
        do {
            let movies = try await dataService.fetchMultipleSuggestions(ids: ["1817", "745", "769", "278", "429"])
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                
                suggestedMovies = movies
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
