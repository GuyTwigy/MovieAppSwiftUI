//
//  ContentView.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import SwiftUI

struct MainView: View {
    @State private var searchText = ""
    @State private var selectedOption: OptionsSelection = .top
    @State var optionTitle = "Top Rated"
    private var optionsArr: [String] = ["Top Rated", "Popular", "Trending", "Now Playing", "Upcoming"]
    let movieData =
    [MovieData(id: 1, idString: "1", title: "title1", posterPath: "posterPath1", overview: "overview1", releaseDate: "releaseDate1", originalLanguage: "EN", voteAverage: 10.0, date: Date()),
     MovieData(id: 2, idString: "2", title: "title2", posterPath: "posterPath2", overview: "overview2", releaseDate: "releaseDate2", originalLanguage: "EN", voteAverage: 9.0, date: Date()),
     MovieData(id: 3, idString: "3", title: "title3", posterPath: "posterPath3", overview: "overview3", releaseDate: "releaseDate3", originalLanguage: "EN", voteAverage: 10.0, date: Date()),
     MovieData(id: 4, idString: "4", title: "title4", posterPath: "posterPath4", overview: "overview4", releaseDate: "releaseDate4", originalLanguage: "EN", voteAverage: 10.0, date: Date()),
     MovieData(id: 5, idString: "5", title: "title5", posterPath: "posterPath5", overview: "overview5", releaseDate: "releaseDate5", originalLanguage: "EN", voteAverage: 10.0, date: Date()),
     MovieData(id: 6, idString: "6", title: "title6", posterPath: "posterPath6", overview: "overview6", releaseDate: "releaseDate6", originalLanguage: "EN", voteAverage: 10.0, date: Date())]
    let moreMovies =
    [MovieData(id: 1, idString: "1", title: "title1", posterPath: "posterPath1", overview: "overview1", releaseDate: "releaseDate1", originalLanguage: "EN", voteAverage: 10.0, date: Date()),
     MovieData(id: 2, idString: "2", title: "title2", posterPath: "posterPath2", overview: "overview2", releaseDate: "releaseDate2", originalLanguage: "EN", voteAverage: 9.0, date: Date()),
     MovieData(id: 3, idString: "3", title: "title3", posterPath: "posterPath3", overview: "overview3", releaseDate: "releaseDate3", originalLanguage: "EN", voteAverage: 10.0, date: Date()),
     MovieData(id: 4, idString: "4", title: "title4", posterPath: "posterPath4", overview: "overview4", releaseDate: "releaseDate4", originalLanguage: "EN", voteAverage: 10.0, date: Date()),
     MovieData(id: 5, idString: "5", title: "title5", posterPath: "posterPath5", overview: "overview5", releaseDate: "releaseDate5", originalLanguage: "EN", voteAverage: 10.0, date: Date()),
     MovieData(id: 6, idString: "6", title: "title6", posterPath: "posterPath6", overview: "overview6", releaseDate: "releaseDate6", originalLanguage: "EN", voteAverage: 10.0, date: Date())]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
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
            .onChange(of: searchText) {
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
            
            Text("Suggested Movies")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movieData, id: \.id) { movie in
                        VStack {
                            Text(movie.title ?? "")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Text(optionTitle)
                .font(.headline)
                .padding(.horizontal)
            
            List(moreMovies) { movie in
                Text(movie.title ?? "")
            }
            .listStyle(PlainListStyle())
        }
        .padding(.top, 20)
    }
}

#Preview {
    MainView()
}
