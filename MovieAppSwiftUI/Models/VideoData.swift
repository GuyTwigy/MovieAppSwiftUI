//
//  VideoData.swift
//  MovieAppSwiftUI
//
//  Created by Guy Twig on 25/06/2024.
//

import Foundation

struct VideoData: Decodable {
    let key: String
    let type: String
}

struct VideosResponse: Decodable {
    let results: [VideoData]
}

