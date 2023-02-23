//
//  MovieListViewViewModel.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 19.02.2023.
//

import Foundation
import RxSwift
import RxCocoa

class MovieListViewViewModel {
    
    //MARK: - Constants
    
    private let movieService: APIService
    private let disposeBag = DisposeBag()
    
    //MARK: - Constructors
    
    init(endpoint: Driver<Endpoint>, movieService: APIService) {
        self.movieService = movieService
        endpoint
            .drive(onNext: { [weak self] (endpoint) in
                print(endpoint)
                self?.fetchMovies(endpoint: endpoint)
        }).disposed(by: disposeBag)
    }
    
    //MARK: - Variables
    
    private let films = BehaviorRelay<[Movie]>(value: [])
    private let isFetchingMovies = BehaviorRelay<Bool>(value: false)
    private let movieError = BehaviorRelay<String?>(value: nil)
    
    var isFetching: Driver<Bool> {
        return isFetchingMovies.asDriver()
    }
    
    var movies: Driver<[Movie]> {
        return films.asDriver()
    }
    
    var error: Driver<String?> {
        return movieError.asDriver()
    }
    
    var hasError: Bool {
        return movieError.value != nil
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
    
    //MARK: - Private Methods
    
    private func fetchMovies(endpoint: Endpoint) {
        self.films.accept([])
        self.isFetchingMovies.accept(true)
        self.movieError.accept(nil)
        
        movieService.fetchMovies(from: endpoint, params: nil, successHandler: {[weak self] (response) in
            self?.isFetchingMovies.accept(false)
            self?.films.accept(Array(response.results.prefix(25)))
            
        }) { [weak self] (error) in
            self?.isFetchingMovies.accept(false)
            self?.movieError.accept(error.localizedDescription)
        }
    }
}

