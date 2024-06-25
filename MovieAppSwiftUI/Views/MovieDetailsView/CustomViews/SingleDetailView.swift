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
        HStack {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
                .foregroundColor(.black)
            
            Text(subtitle)
                .font(.headline)
                .padding(.horizontal)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SingleDetailView(title: "Guy:", subtitle: "Twig")
}
