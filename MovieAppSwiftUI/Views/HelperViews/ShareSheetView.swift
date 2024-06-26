//
//  ShareSheetView.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 26/06/2024.
//

import SwiftUI
import Kingfisher

struct ShareSheetView: UIViewControllerRepresentable {
    let movie: MovieData
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        var itemsToShare: [Any] = [
            "Movie Name: \(movie.title ?? "Not available")\n" +
            "Language: \(movie.originalLanguage ?? "Not available")\n" +
            "Release Date: \(movie.releaseDate ?? "Not available")\n" +
            "Rating: \(movie.voteAverage?.description ?? "-")/10"
        ]
        
        if let posterPath = movie.posterPath, let imageUrl = Utils.getImageUrl(posterPath: posterPath) {
            itemsToShare.append(KFImage(imageUrl))
        }
        
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        activityViewController.modalPresentationStyle = .popover
        activityViewController.popoverPresentationController?.permittedArrowDirections = []
        activityViewController.popoverPresentationController?.sourceView = context.coordinator.sourceView
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
        
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator {
        var sourceView: UIView?
    }
}

//#Preview {
//    ShareSheetView(movie: MovieData(id: 1, idString: "1", title: "title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 ", posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", overview: "overview1", releaseDate: "releaseDate1", originalLanguage: "EN", voteAverage: 10.0, date: Date()))
//}
