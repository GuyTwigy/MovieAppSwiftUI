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
        if let movie {
            detailsArr.removeAll()
            detailsArr = [SingleDetail(title: "Overiew:", description: movie.overview ?? "Not Available"),
                          SingleDetail(title: "Rating:", description: "\(movie.voteAverage?.description ?? "-")/10"),
                          SingleDetail(title: "Language:", description: movie.originalLanguage ?? "Not Available"),
                          SingleDetail(title: "Release Date:", description: movie.releaseDate ?? "Not Available")]
            self.movie = movie
        } else {
            // handle error
        }
    }
    
    func getTrailer(id: Int) async {
        do {
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
            // handle error
        }
    }
}
