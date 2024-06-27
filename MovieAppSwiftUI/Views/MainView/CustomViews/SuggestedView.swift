//
//  SuggestedView.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import SwiftUI
import Kingfisher

struct SuggestedView: View {
    let movie: MovieData
   
    
    var body: some View {
        HStack {
            ZStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: 65, height: 65)
                
                if let imageURL = Utils.getImageUrl(posterPath: movie.posterPath ?? "") {
                    KFImage(imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 80)
                        .clipped()
                        .cornerRadius(8)
                        .padding()
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title ?? "")
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.tail)
                    .padding(.trailing, 10)
                
                Text(String(format: "Rating: %.2f/10", movie.voteAverage ?? 0.0))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.tail)
                    .padding(.trailing, 10)
            }
            .padding(.horizontal, 5)
            .padding(.bottom, 5)
        }
        .background(Color.white)
        .cornerRadius(8)
        .frame(width: UIScreen.main.bounds.width / 1.5, height: 200)
        .shadow(radius: 2)
        .padding(.all, 10)
    }
}

#Preview {
    SuggestedView(movie: MovieData(id: 1, title: "title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 ", posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", overview: "overview1", releaseDate: "releaseDate1", originalLanguage: "EN", voteAverage: 10.0))
}
