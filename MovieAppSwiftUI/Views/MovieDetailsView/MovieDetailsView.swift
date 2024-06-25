//
//  MovieDetailsView.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    @ObservedObject var MovieDetailsViewModel: MovieDetailsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                
            }) {
                Image(systemName: "arrow.backward")
                    .frame(width: 50, height: 50)
                    .background(Color(UIColor.opaqueSeparator))
                    .foregroundColor(.white)
                    .cornerRadius(25)
            }
            .padding(.top)
            .padding(.leading)

            // Movie Title Label
            Text(MovieDetailsViewModel.movie?.title ?? "")
                .font(.system(size: 30, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
                .padding(.top, 10)

            List {
                ForEach(MovieDetailsViewModel.detailsArr, id: \.self) { detail in
                    SingleDetailView(title: detail.title, subtitle: detail.description)
                }
            }
            .background(Color(UIColor.systemBackground))
            .listStyle(PlainListStyle())
            
            if let imageURL = Utils.getImageUrl(posterPath: MovieDetailsViewModel.movie?.posterPath ?? "") {
                KFImage(imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipped()
                    .cornerRadius(8)
                    .padding()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipped()
                    .cornerRadius(8)
                    .background(Color.gray)
            }
        }
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MovieDetailsView(MovieDetailsViewModel: MovieDetailsViewModel(dataService: NetworkManager(), movie: MovieData(id: 1, idString: "1", title: "title 1", posterPath: "posterPath 1", overview: "overview 1", releaseDate: "releaseDate 1", originalLanguage: "originalLanguage 1", voteAverage: 10.0, date: Date())))
}
