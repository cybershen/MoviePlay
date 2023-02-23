//
//  MovieListViewController.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 19.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: - Variables
    
    var movieListViewViewModel: MovieListViewViewModel!
    let disposeBag = DisposeBag()
    
    //MARK: - Lifecycle
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListViewViewModel = MovieListViewViewModel(endpoint: segmentedControl.rx.selectedSegmentIndex
            .map { Endpoint(index: $0) ?? .nowPlaying }
            .asDriver(onErrorJustReturn: .nowPlaying)
            , movieService: APIStore.shared)
        
        movieListViewViewModel.movies.drive(onNext: {[unowned self] (_) in
            self.tableView.reloadData()
        })
        .disposed(by: disposeBag)
        
        movieListViewViewModel.isFetching.drive(activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        movieListViewViewModel.error.drive(onNext: {[unowned self] (error) in
            self.infoLabel.isHidden = !self.movieListViewViewModel.hasError
            self.infoLabel.text = error
        })
        .disposed(by: disposeBag)
        
        setupTableView()
    }
    
    //MARK: - Private Methods

    private func setupTableView() {
        tableView.estimatedRowHeight = 100
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
}

//MARK: - UITableView Delegate

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewViewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        if let viewModel = movieListViewViewModel.viewModelForMovie(at: indexPath.row) {
            cell.configure(viewModel: viewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieListViewViewModel.viewModelForMovie(at: indexPath.row)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailMovieViewController") as? DetailMovieViewController {
            
            DispatchQueue.main.async { [weak self] in
                vc.myModel = movie
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
