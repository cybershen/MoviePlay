//
//  MovieSearchViewViewModel.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 19.02.2023.
//

import Foundation
import RxSwift
import RxCocoa

class MovieSearchViewViewModel {
    
    private let movieService: MovieService
    private let disposeBag = DisposeBag()
    
    init(query: Driver<String>, movieService: MovieService) {
        self.movieService = movieService
        query
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (queryString) in
                self?.searchMovie(query: queryString)
                if queryString.isEmpty {
                    self?.films.accept([])
                    self?.movieInfo.accept("Start searching your favorite movies")
                }
            }).disposed(by: disposeBag)
    }
    
    private let films = BehaviorRelay<[Movie]>(value: [])
    private let isFetchingMovies = BehaviorRelay<Bool>(value: false)
    private let movieInfo = BehaviorRelay<String?>(value: nil)
    
    var isFetching: Driver<Bool> {
        return isFetchingMovies.asDriver()
    }
    
    var movies: Driver<[Movie]> {
        return films.asDriver()
    }
    
    var info: Driver<String?> {
        return movieInfo.asDriver()
    }
    
    var hasInfo: Bool {
        return movieInfo.value != nil
    }
    
    var numberOfMovies: Int {
        return films.value.count
    }
    
    func viewModelForMovie(at index: Int) -> MovieViewViewModel? {
        guard index < films.value.count else {
            return nil
        }
        return MovieViewViewModel(movie: films.value[index])
    }
    
    private func searchMovie(query: String?) {
        guard let query = query, !query.isEmpty else {
            return
        }
        
        self.films.accept([])
        self.isFetchingMovies.accept(true)
        self.movieInfo.accept(nil)
        
        movieService.searchMovie(query: query, params: nil, successHandler: {[weak self] (response) in
            
            self?.isFetchingMovies.accept(false)
            if response.totalResults == 0 {
                self?.movieInfo.accept("No result for \(query)")
            }
            self?.films.accept(Array(response.results.prefix(5)))
        }) { [weak self] (error) in
            self?.isFetchingMovies.accept(false)
            self?.movieInfo.accept(error.localizedDescription)
        }
    }
}

