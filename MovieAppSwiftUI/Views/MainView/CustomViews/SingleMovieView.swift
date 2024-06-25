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
                if let imageURL = URL(string: movie.posterPath ?? "") {
                    KFImage(imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipped()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 150)
                        .clipped()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .background(Color.gray)
                }
                
                Text(movie.title ?? "")
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .truncationMode(.tail)
                Spacer()
            }
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
    SingleMovieView(movie: MovieData(id: 1, idString: "1", title: "title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 title1 ", posterPath: "posterPath1", overview: "overview1", releaseDate: "releaseDate1", originalLanguage: "EN", voteAverage: 10.0, date: Date()))
}
