//
//  TitleViewModel.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 15.02.2023.
//

import Foundation
import RxSwift
import RxCocoa

struct TitleListViewModel {
    let titlesVM: [TitleViewModel]
}

extension TitleListViewModel {
    init(_ titles: [Title]) {
        self.titlesVM = titles.compactMap(TitleViewModel.init)
    }
}

extension TitleListViewModel {
    func titleAt(_ index: Int) -> TitleViewModel {
        return self.titlesVM[index]
    }
}

struct TitleViewModel {
    let title: Title
    
    init(_ title: Title) {
        self.title = title
    }
}

extension TitleViewModel {
    var id: Observable<Int> {
        return Observable<Int>.just(title.id)
    }
    
    var media_type: Observable<String> {
        return Observable<String>.just(title.media_type ?? "")
    }
    
    var original_name: Observable<String> {
        return Observable<String>.just(title.original_name ?? "")
    }
    
    var original_title: Observable<String> {
        return Observable<String>.just(title.original_title ?? "")
    }
    
    var poster_path: Observable<String> {
        return Observable<String>.just(title.poster_path ?? "")
    }
    
    var overview: Observable<String> {
        return Observable<String>.just(title.overview ?? "")
    }
    
    var vote_count: Observable<Int> {
        return Observable<Int>.just(title.vote_count)
    }
    
    var release_date: Observable<String> {
        return Observable<String>.just(title.release_date ?? "")
    }
    
    var vote_average: Observable<Double> {
        return Observable<Double>.just(title.vote_average)
    }
}
