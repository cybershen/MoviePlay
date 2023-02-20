//
//  MovieCell.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 19.02.2023.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configure(viewModel: MovieViewViewModel) {
        titleLabel.text = viewModel.title
        overviewLabel.text = viewModel.overview
        releaseDateLabel.text = viewModel.releaseDate
        ratingLabel.text = viewModel.rating
        posterImageView.sd_setImage(with: viewModel.posterURL)
    }
}
