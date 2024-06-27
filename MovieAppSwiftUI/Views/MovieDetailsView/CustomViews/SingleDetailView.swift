//
//  SingleDetailView.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import SwiftUI

struct SingleDetailView: View {
    
    @State var title: String
    @State var subtitle: String
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 25, weight: .bold))
                    .padding(.horizontal)
                    .foregroundColor(.black)
                
                Text(subtitle)
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(.black)
            }
            
            Divider()
                .background(Color(.lightGray))
                .padding(.horizontal)
        }
    }
}

#Preview {
    SingleDetailView(title: "Guy:", subtitle: "Twig")
}
