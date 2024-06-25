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
            .onChange(of: searchText) { _ in
                if searchText != "" {
                    optionTitle = "Search result for '\(searchText)'"
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(optionsArr, id: \.self) { item in
                        Text(item)
                            .font(.system(size: 14))
                            .padding()
                            .frame(height: 25)
                            .background(selectedOption.rawValue == item ? Color.cyan : Color.white)
                            .foregroundColor(selectedOption.rawValue == item ? Color.white : Color.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                            .padding(.horizontal)
                            .onTapGesture {
                                searchText = ""
                                selectedOption = OptionsSelection(rawValue: item) ?? .top
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                optionTitle = selectedOption.rawValue
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
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .padding(.leading, 10)
            .padding(.vertical, -50.0)
            
            ZStack(alignment: .leading) {
                Color.white
                    .frame(maxWidth: .infinity)
                
                Text(optionTitle)
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(.black)
            }
            .frame(height: 25)
            
            List(moreMovies) { movie in
                SingleMovieView(movie: movie)
            }
            .listStyle(PlainListStyle())
        }
        .background(Color(.systemGray2))
    }
}

#Preview {
    MainView()
}
