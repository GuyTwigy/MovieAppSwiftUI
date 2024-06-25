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
    
    func fetchMovies(optionSelection: OptionsSelection, query: String, page: Int, addContent: Bool) async {
        do {
            let moviesRoot = try await dataService.fetchMovies(optionSelected: optionSelection, query: query, page: page)
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                
                self.movieRoot = nil
                self.movieRoot = moviesRoot
                if addContent {
                    self.moviesList.append(contentsOf: moviesRoot.results ?? [])
                } else {
                    self.moviesList = moviesRoot.results ?? []
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
