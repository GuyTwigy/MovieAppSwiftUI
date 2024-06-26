//
//  TrailerViewModel.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 26/06/2024.
//

import Foundation

@MainActor
class TrailerViewModel: ObservableObject {
        
    @Published var request: URLRequest?
    @Published var showError: Bool = false
    
    var videoKey: String
    
    init(videoKey: String) {
        self.videoKey = videoKey
        loadVideo()
    }
    
    func loadVideo() {
        let urlString = "https://www.youtube.com/embed/\(videoKey)"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            self.request = request
        } else {
            showError = true
        }
    }
}
