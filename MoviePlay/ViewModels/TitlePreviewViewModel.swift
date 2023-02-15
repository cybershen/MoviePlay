//
//  TitlePreviewViewModel.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 15.02.2023.
//

import Foundation
import RxSwift
import RxCocoa

struct TitlePreviewViewModel {
    let title: Title
    let youtubeView: VideoElement
    
    init(_ title: Title, _ youtubeView: VideoElement) {
        self.title = title
        self.youtubeView = youtubeView
    }
}

extension TitlePreviewViewModel {
    var name: Observable<String> {
        return Observable<String>.just(title.original_name ?? "")
    }
    
    var video: Observable<String> {
        return Observable<String>.just(youtubeView.id.videoId)
    }
    
    var titleOverview: Observable<String> {
        return Observable<String>.just(title.overview ?? "")
    }
}
