//
//  MovieDetailsView.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import SwiftUI
import Kingfisher


struct MovieDetailsView: View {
    
    @ObservedObject var vm: MovieDetailsViewModel
    @State private var showTrailerSheet = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isShareSheetPresented = false
    
    var body: some View {
        Text(vm.movie?.title ?? "")
            .multilineTextAlignment(.center)
            .font(.system(size: 30, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
            .padding(.top, 10)
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if !vm.showUIError {
                    ZStack(alignment: .topTrailing) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        
                        if let imageURL = Utils.getImageUrl(posterPath: vm.movie?.posterPath ?? "") {
                            KFImage(imageURL)
                                .resizable()
                                .frame(minWidth: UIScreen.main.bounds.width)
                                .aspectRatio(contentMode: .fill)
                        }
                        
                        Button(action: {
                            isShareSheetPresented.toggle()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .padding(10)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(15)
                        }
                        .sheet(isPresented: $isShareSheetPresented) {
                            if let movie = vm.movie {
                                ShareSheetView(movie: movie)
                            }
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(vm.detailsArr, id: \.self) { detail in
                            SingleDetailView(title: detail.title, subtitle: detail.description)
                                .padding(.horizontal)
                                .background(Color(UIColor.systemBackground))
                        }
                    }
                    
                    ZStack {
                        HStack {
                            Button(action: {
                                print("show trailer tapped")
                                Task {
                                    await vm.getTrailer(id: vm.movie?.id ?? 1)
                                    if vm.video != nil {
                                        showTrailerSheet = true
                                    }
                                    if vm.showTrailerError {
                                        showError = true
                                        errorMessage = "Failed to load trailer"
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            withAnimation {
                                                showError = false
                                                errorMessage = ""
                                            }
                                        }
                                    }
                                }
                            }) {
                                Spacer()
                                Text("Show Trailer")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(Color.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                } else {
                    ErrorView(showError: $vm.showUIError, errorMessage: "Movie is not available")
                        .foregroundColor(.black)
                        .padding()
                }
            }
            .background(Color(UIColor.systemBackground))
            .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $showTrailerSheet) {
            if let video = vm.video {
                TrailerView(vm: TrailerViewModel(videoKey: video.key))
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        }
        .overlay(
            Group {
                if showError {
                    VStack {
                        Text(errorMessage)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 10)
                    .transition(.move(edge: .top))
                }
            }
        )
    }
}

#Preview {
    MovieDetailsView(vm: MovieDetailsViewModel(dataService: NetworkManager(), movie: MovieData(id: 1, idString: "1", title: "title 1 title 1 title 1 title 1 title 1 title 1 title 1 v", posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", overview: "overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1", releaseDate: "releaseDate 1", originalLanguage: "originalLanguage 1", voteAverage: 10.0, date: Date())))
}
