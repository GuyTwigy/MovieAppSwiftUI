//
//  SingleMovieView.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import SwiftUI

import SwiftUI
import Kingfisher

struct SingleMovieView: View {
    let movie: MovieData
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 65, height: 65)
                    
                    if let imageURL = Utils.getImageUrl(posterPath: movie.posterPath ?? "") {
                        KFImage(imageURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40)
                            .clipped()
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                }
                
                Spacer()
                
                Text(movie.title ?? "")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: false)
                    .truncationMode(.tail)
                    .padding(.vertical, 5.0)
                
                Spacer()
            }
            .frame(height: 50)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
        }
        .padding()
        .background(Color(.systemGray2))
    }
}

#Preview {
    SingleMovieView(movie: MovieData(id: 1, title: "title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 ", posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", overview: "overview1", releaseDate: "releaseDate1", originalLanguage: "EN", voteAverage: 10.0))
}
