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
            KingfisherManager.shared.retrieveImage(with: imageUrl) { retrieveImageResult in
                switch retrieveImageResult {
                case .success(_):
                    do {
                        let image = try retrieveImageResult.get().image
                        itemsToShare.append(image)
                    } catch {
                        print("Fail to fetch image to share, error: \(error.localizedDescription)")
                    }
                case .failure(_):
                    print("Fail to fetch image to share")
                }
            }
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
