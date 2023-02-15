//
//  HomeViewController.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 14.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

enum Sections: Int {
    case trendingMovies = 0
    case trendingTv = 1
    case popular = 2
    case upcomingMovies = 3
    case topRated = 4
}

class HomeViewController: UIViewController {
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let sectionTitles = ["Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top Rated"]
    
    private var trendingMovies: [Title]?
    private var trendingTvs: [Title]?
    private var popularMovies: [Title]?
    private var upcomingMovies: [Title]?
    private var topRatedMovies: [Title]?
    
    let disposeBag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CollectionViewTableViewCell .self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        fetchTitles()
        setRandomImage()
    }
    
    private func setRandomImage() {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(trendingMovies![0].poster_path)") else { return }
        
        heroImageView.sd_setImage(with: url)
        
        print("Image seted")
    }
    
    private func fetchTitles() {
        URLRequest.load(resource: TrendingTitleResponse.trendingMovies)
            .subscribe(onNext: { [weak self] titlesList in
                
                self?.trendingMovies = titlesList?.results
    
            })
            .disposed(by: disposeBag)
        
        URLRequest.load(resource: TrendingTitleResponse.trendingTvs)
            .subscribe(onNext: { [weak self] titlesList in
                
                self?.trendingTvs = titlesList?.results
    
            })
            .disposed(by: disposeBag)
        
        URLRequest.load(resource: TrendingTitleResponse.popularMovies)
            .subscribe(onNext: { [weak self] titlesList in
                
                self?.popularMovies = titlesList?.results
    
            })
            .disposed(by: disposeBag)
        
        URLRequest.load(resource: TrendingTitleResponse.upcomingMovies)
            .subscribe(onNext: { [weak self] titlesList in
                
                self?.upcomingMovies = titlesList?.results
    
            })
            .disposed(by: disposeBag)
        
        URLRequest.load(resource: TrendingTitleResponse.topRatedMovies)
            .subscribe(onNext: { [weak self] titlesList in
                
                self?.topRatedMovies = titlesList?.results
    
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case Sections.trendingMovies.rawValue:
            
            cell.configure(with: trendingMovies!)
            
            
        case Sections.trendingTv.rawValue:
            
            cell.configure(with: trendingTvs!)
            
        case Sections.popular.rawValue:
            
            cell.configure(with: popularMovies!)
    
        case Sections.upcomingMovies.rawValue:
            
            cell.configure(with: upcomingMovies!)
        
            
        case Sections.topRated.rawValue:
            
            cell.configure(with: topRatedMovies!)
       
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20 , y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}
