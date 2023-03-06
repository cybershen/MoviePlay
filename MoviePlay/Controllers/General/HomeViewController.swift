//
//  HomeViewController.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 19.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    
    var movieListViewViewModel: MovieListViewViewModel!
    let disposeBag = DisposeBag()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        movieListViewViewModel = MovieListViewViewModel(endpoint: segmentedControl.rx.selectedSegmentIndex
            .map { Endpoint(index: $0) ?? .upcoming }
            .asDriver(onErrorJustReturn: .upcoming)
            ,movieService: APIStore.shared)
        
        movieListViewViewModel.movies.drive(onNext: {[unowned self] (_) in
            self.collectionView.reloadData()
        })
        .disposed(by: disposeBag)
        
        movieListViewViewModel.isFetching.drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Private Methods
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 210, height: 315)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
    }
    
    private func configure(with viewModel: MovieListViewViewModel) {
        self.movieListViewViewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionView Delegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieListViewViewModel.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let movie = movieListViewViewModel.viewModelForMovie(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        
        cell.configure(viewModel: movie)
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = movieListViewViewModel.viewModelForMovie(at: indexPath.row)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailMovieViewController") as? DetailMovieViewController {
            
            DispatchQueue.main.async { [weak self] in
                vc.myModel = movie
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
