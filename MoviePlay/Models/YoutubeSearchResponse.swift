//
//  YoutubeSearchResponse.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 14.02.2023.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: idVideoElement
}

struct idVideoElement: Codable {
    let kind: String
    let videoId: String
}
