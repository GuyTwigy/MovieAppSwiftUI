//
//  TrailerView.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 26/06/2024.
//

import SwiftUI

struct TrailerView: View {
    
    @ObservedObject var vm: TrailerViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Color.white
                .frame(height: 10)
                .padding(.top, 5)
            
            if let request = vm.request {
                WebView(request: request)
                    .edgesIgnoringSafeArea(.all)
            } else {
                ErrorView(showError: $vm.showError, errorMessage: "Failed to load video")
                    .foregroundColor(.black)
                    .padding()
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    TrailerView(vm: TrailerViewModel(videoKey: "PLl99DlL6b4"))
}
