//
//  MainViewModel.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import Foundation

@MainActor
class MainViewModel: ObservableObject {
    
    @Published var suggestedMovies: [MovieData] = []
    @Published var moviesList: [MovieData] = []
    @Published var suggestedError: Bool = false
    @Published var fetchingError: Bool = false
    
    
    var movieRoot: MoviesRoot?
    var dataService = NetworkManager()
    
    init() {
        Task {
            await fetchSuggestions()
            await fetchMovies(optionSelection: .top, query: "", page: 1, addContent: false)
        }
    }
    
    func fetchSuggestions() async {
        do {
            let movies = try await dataService.fetchMultipleSuggestions(ids: ["1817", "745", "769", "278", "429"])
            self.suggestedMovies = movies
        } catch {
            print("Error: \(error.localizedDescription)")
            suggestedError = true
        }
    }
    
    func fetchMovies(optionSelection: OptionsSelection, query: String, page: Int, addContent: Bool) async {
        do {
            let moviesRoot = try await dataService.fetchMovies(optionSelected: optionSelection, query: query, page: page)
            self.movieRoot = nil
            self.movieRoot = moviesRoot
            if addContent {
                self.moviesList.append(contentsOf: moviesRoot.results ?? [])
            } else {
                self.moviesList.removeAll()
                self.moviesList = moviesRoot.results ?? []
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            if moviesList.isEmpty {
                fetchingError = true
            }
        }
    }
}
