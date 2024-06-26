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

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(vm.movie?.title ?? "")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                if let imageURL = Utils.getImageUrl(posterPath: vm.movie?.posterPath ?? "") {
                    KFImage(imageURL)
                        .resizable()
                        .frame(minWidth: UIScreen.main.bounds.width)
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(8)
                        .background(Color.gray)
                        .padding()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(vm.detailsArr, id: \.self) { detail in
                        SingleDetailView(title: detail.title, subtitle: detail.description)
                            .padding(.horizontal)
                            .background(Color(UIColor.systemBackground))
                    }
                }
                
                
            }
            .background(Color(UIColor.systemBackground))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    MovieDetailsView(vm: MovieDetailsViewModel(dataService: NetworkManager(), movie: MovieData(id: 1, idString: "1", title: "title 1 title 1 title 1 title 1 title 1 title 1 title 1 v", posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", overview: "overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1 overview 1", releaseDate: "releaseDate 1", originalLanguage: "originalLanguage 1", voteAverage: 10.0, date: Date())))
}
