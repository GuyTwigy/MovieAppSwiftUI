//
//  ErrorView.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 26/06/2024.
//

import SwiftUI

struct ErrorView: View {
    
    @Binding var showError: Bool
    var errorMessage: String
    
    var body: some View {
        VStack {
            Text(errorMessage)
                .font(.headline)
                .padding(.top, 80)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red.opacity(0.1))
    }
}
