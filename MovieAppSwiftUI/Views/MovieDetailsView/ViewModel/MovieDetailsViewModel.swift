//
//  MovieDetailsViewModel.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import Foundation

@MainActor
class MovieDetailsViewModel: ObservableObject {
    
    @Published var movie: MovieData?
    @Published var detailsArr: [SingleDetail] = []
    @Published var video: VideoData?
    @Published var showUIError: Bool = false
    @Published var showTrailerError: Bool = false
    
    var dataService: GetTrailerProtocol
    
    struct SingleDetail: Hashable {
        let title: String
        let description: String
    }
    
    init(dataService: GetTrailerProtocol, movie: MovieData) {
        self.dataService = dataService
        self.movie = movie
        updateUI()
    }
    
    func updateUI() {
        showUIError = false
        if let movie {
            detailsArr.removeAll()
            detailsArr = [SingleDetail(title: "Overiew:", description: movie.overview ?? "Not Available"),
                          SingleDetail(title: "Rating:", description: "\(movie.voteAverage?.description ?? "-")/10"),
                          SingleDetail(title: "Language:", description: movie.originalLanguage ?? "Not Available"),
                          SingleDetail(title: "Release Date:", description: movie.releaseDate ?? "Not Available")]
            self.movie = movie
        } else {
            showUIError = true
        }
    }
    
    func getTrailer(id: Int) async {
        do {
            showTrailerError = false
            let videoData = try await dataService.getTrailer(id: "\(id)")
            if let trailerVideo = videoData.first(where: { $0.type == "Trailer" }) {
                self.video = trailerVideo
            } else if let clipVideo = videoData.first(where: { $0.type == "Clip" })  {
                self.video = clipVideo
            } else {
                self.video = videoData.first
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            showTrailerError = true
        }
    }
}
