//
//  WebView.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 26/06/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var request: URLRequest?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let request = request {
            uiView.load(request)
        }
    }
}
