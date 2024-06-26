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
    
    var body: some View {
        NavigationView {
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
                            NavigationLink(destination: MovieDetailsView(vm: MovieDetailsViewModel(dataService: vm.dataService, movie: movie))) {
                                SuggestedView(movie: movie)
                            }
                        }
                    }
                }
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
                
                ScrollViewReader { proxy in
                    List(vm.moviesList, id: \.id) { movie in
                        ZStack {
                            SingleMovieView(movie: movie)
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: 80)
                                .onAppear {
                                    if !vm.moviesList.isEmpty && movie == vm.moviesList[vm.moviesList.count - 3] {
                                        Task {
                                            await vm.fetchMovies(optionSelection: selectedOption, query: "", page: (vm.movieRoot?.page ?? 1) + 1, addContent: true)
                                        }
                                    }
                                }
                            NavigationLink(destination: MovieDetailsView(vm: MovieDetailsViewModel(dataService: vm.dataService, movie: movie))) {
                                EmptyView()
                            }
                            .opacity(0)
                        }
                        .background(Color(.systemGray2))
                        .listRowBackground(Color(.systemGray2))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color(.systemGray2))
                    .gesture(DragGesture().onChanged { _ in
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        })
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
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

#Preview {
    MainView()
}
