//
//  HomeViewController.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 14.02.2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var heroHeaderView: UIView!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let sectionTitles = ["Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top Rated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroImageView.image = UIImage(named: "poster.jpg")
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor]
        gradientLayer.frame = heroHeaderView.bounds
        heroHeaderView.layer.addSublayer(gradientLayer)
    }
}
