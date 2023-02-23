//
//  MovieSearchViewController.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 19.02.2023.
//

import UIKit
import RxCocoa
import RxSwift

class MovieSearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    var movieSearchViewViewModel: MovieSearchViewViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        let searchBar = self.navigationItem.searchController!.searchBar
        
        movieSearchViewViewModel = MovieSearchViewViewModel(query: searchBar.rx.text.orEmpty.asDriver(), movieService: APIStore.shared)
        
        movieSearchViewViewModel.movies.drive(onNext: {[unowned self] (_) in
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        movieSearchViewViewModel.isFetching.drive(activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    
        movieSearchViewViewModel.info.drive(onNext: {[unowned self] (info) in
            self.infoLabel.isHidden = !self.movieSearchViewViewModel.hasInfo
            self.infoLabel.text = info
        }).disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [unowned searchBar] in
                searchBar.resignFirstResponder()
                self.collectionView.reloadData()
            }).disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [unowned searchBar] in
                searchBar.resignFirstResponder()
            }).disposed(by: disposeBag)
        
        setupCollectionView()
    }
    
    //MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.definesPresentationContext = true
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        navigationItem.searchController?.searchBar.sizeToFit()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemOrange
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 137, height: 203)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.backgroundColor = .black
    }
}

//MARK: UICollectionView Delegate

extension MovieSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieSearchViewViewModel.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        if let viewModel = movieSearchViewViewModel.viewModelForMovie(at: indexPath.row) {
            cell.configure(viewModel: viewModel)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieSearchViewViewModel.viewModelForMovie(at: indexPath.row)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailMovieViewController") as? DetailMovieViewController {
            
            DispatchQueue.main.async { [weak self] in
                vc.myModel = movie
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
