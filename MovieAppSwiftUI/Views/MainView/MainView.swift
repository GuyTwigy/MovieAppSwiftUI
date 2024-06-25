//
//  MainView.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var vm = MainViewModel()
    @State private var searchText = ""
    @State private var selectedOption: OptionsSelection = .top
    @State private var optionTitle = "Top Rated"
    
    private let optionsArr: [String] = ["Top Rated", "Popular", "Trending", "Now Playing", "Upcoming"]
    private let movieData: [MovieData] = [
        MovieData(id: 1, idString: "1", title: "title 1", posterPath: "posterPath 1", overview: "overview 1", releaseDate: "releaseDate 1", originalLanguage: "originalLanguage 1", voteAverage: 10.0, date: Date()),
        MovieData(id: 2, idString: "2", title: "title 2", posterPath: "posterPath 2", overview: "overview 2", releaseDate: "releaseDate 2", originalLanguage: "originalLanguage 2", voteAverage: 9.0, date: Date()),
        MovieData(id: 3, idString: "3", title: "title 3", posterPath: "posterPath 3", overview: "overview 3", releaseDate: "releaseDate 3", originalLanguage: "originalLanguage 3", voteAverage: 8.0, date: Date()),
        MovieData(id: 4, idString: "4", title: "title 4", posterPath: "posterPath 4", overview: "overview 4", releaseDate: "releaseDate 4", originalLanguage: "originalLanguage 4", voteAverage: 7.0, date: Date()),
        MovieData(id: 5, idString: "5", title: "title 5", posterPath: "posterPath 5", overview: "overview 5", releaseDate: "releaseDate 5", originalLanguage: "originalLanguage 5", voteAverage: 6.0, date: Date()),
        MovieData(id: 6, idString: "6", title: "title 6", posterPath: "posterPath 6", overview: "overview 6", releaseDate: "releaseDate 6", originalLanguage: "originalLanguage 6", voteAverage: 5.0, date: Date())]
    
    private let moreMovies: [MovieData] = [
        MovieData(id: 1, idString: "1", title: "title 1", posterPath: "posterPath 1", overview: "overview 1", releaseDate: "releaseDate 1", originalLanguage: "originalLanguage 1", voteAverage: 10.0, date: Date()),
        MovieData(id: 2, idString: "2", title: "title 2", posterPath: "posterPath 2", overview: "overview 2", releaseDate: "releaseDate 2", originalLanguage: "originalLanguage 2", voteAverage: 9.0, date: Date()),
        MovieData(id: 3, idString: "3", title: "title 3", posterPath: "posterPath 3", overview: "overview 3", releaseDate: "releaseDate 3", originalLanguage: "originalLanguage 3", voteAverage: 8.0, date: Date()),
        MovieData(id: 4, idString: "4", title: "title 4", posterPath: "posterPath 4", overview: "overview 4", releaseDate: "releaseDate 4", originalLanguage: "originalLanguage 4", voteAverage: 7.0, date: Date()),
        MovieData(id: 5, idString: "5", title: "title 5", posterPath: "posterPath 5", overview: "overview 5", releaseDate: "releaseDate 5", originalLanguage: "originalLanguage 5", voteAverage: 6.0, date: Date()),
        MovieData(id: 6, idString: "6", title: "title 6", posterPath: "posterPath 6", overview: "overview 6", releaseDate: "releaseDate 6", originalLanguage: "originalLanguage 6", voteAverage: 5.0, date: Date())]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 10) {
                TextField("Search...", text: $searchText, onEditingChanged: { isEditing in
                    if isEditing {
                        selectedOption = .search
                        optionTitle = "Search result for '\(searchText)'"
                    }
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                .onChange(of: searchText) { newValue in
                    if !newValue.isEmpty {
                        optionTitle = "Search result for '\(searchText)'"
                        Task {
                            await vm.fetchMovies(optionSelection: .search, query: searchText, page: 1, addContent: false)
                        }
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(optionsArr, id: \.self) { item in
                            Text(item)
                                .font(.system(size: 14))
                                .padding(.horizontal)
                                .frame(height: 30)
                                .background(selectedOption.rawValue == item ? Color.cyan : Color.white)
                                .foregroundColor(selectedOption.rawValue == item ? Color.white : Color.black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .padding(.vertical, 3)
                                .onTapGesture {
                                    searchText = ""
                                    selectedOption = OptionsSelection(rawValue: item) ?? .top
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    optionTitle = selectedOption.rawValue
                                    Task {
                                        await vm.fetchMovies(optionSelection: selectedOption, query: "", page: 1, addContent: false)
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                
                ZStack(alignment: .leading) {
                    Color.white
                        .frame(maxWidth: .infinity)
                    
                    Text("Suggested Movies")
                        .font(.headline)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                }
                .frame(height: 25)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(vm.suggestedMovies, id: \.id) { movie in
                            SuggestedView(movie: movie)
                        }
                    }
                }
                .padding(.vertical, -35.0)
                
                ZStack(alignment: .leading) {
                    Color.white
                        .frame(maxWidth: .infinity)
                    
                    Text(optionTitle)
                        .font(.headline)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                }
                .frame(height: 25)
                
                ScrollViewReader { proxy in
                    List(vm.moviesList, id: \.id) { movie in
                        SingleMovieView(movie: movie)
                            .listRowBackground(Color(.systemGray2))
                            .listRowSeparator(.hidden)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 80)
                            .onAppear {
                                if !vm.moviesList.isEmpty && movie == vm.moviesList[vm.moviesList.count - 3] {
                                    Task {
                                        await vm.fetchMovies(optionSelection: selectedOption, query: "", page: (vm.movieRoot?.page ?? 1) + 1, addContent: true)
                                    }
                                }
                            }
                            .id(movie.id)
                    }
                    .listStyle(PlainListStyle())
                    .onChange(of: selectedOption) { _ in
                        withAnimation {
                            proxy.scrollTo(vm.moviesList.first?.id, anchor: .top)
                        }
                    }
                    .onChange(of: searchText) { _ in
                        withAnimation {
                            proxy.scrollTo(vm.moviesList.first?.id, anchor: .top)
                        }
                    }
                }
            }
            .background(Color(.systemGray2))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

#Preview {
    MainView()
}
