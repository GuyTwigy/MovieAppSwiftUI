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
    @Published var suggestionIsLading: Bool = false
    
    var movieRoot: MoviesRoot?
    var dataService = NetworkManager()
    
    init() {
        Task {
            await fetchSuggestions()
            await fetchMovies(optionSelection: .top, query: "", page: 1, addContent: false)
        }
    }
    
    func fetchSuggestions() async {
        suggestedError = false
        suggestionIsLading = true
        do {
            let movies = try await dataService.fetchMultipleSuggestions(ids: ["1817", "745", "769", "278", "429"])
            suggestionIsLading = false
            self.suggestedMovies = movies
        } catch {
            print("Error: \(error.localizedDescription)")
            suggestionIsLading = false
            suggestedError = true
        }
    }
    
    func fetchMovies(optionSelection: OptionsSelection, query: String, page: Int, addContent: Bool) async {
        fetchingError = false
        if !addContent {
            moviesList.removeAll()
        }
        do {
            let moviesRoot = try await dataService.fetchMovies(optionSelected: optionSelection, query: query, page: page)
            movieRoot = nil
            movieRoot = moviesRoot
            if addContent {
                moviesList.append(contentsOf: moviesRoot.results ?? [])
            } else {
                moviesList = moviesRoot.results ?? []
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            if moviesList.isEmpty {
                fetchingError = true
            }
        }
    }
}
