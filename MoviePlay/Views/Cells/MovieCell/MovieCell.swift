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
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    let gradient = GradientView()
    
    func configure(viewModel: MovieViewViewModel) {
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        ratingLabel.text = viewModel.rating
        posterImageView.sd_setImage(with: viewModel.posterURL)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = cellView.bounds
        gradient.alpha = 0.2
        cellView.addSubview(gradient)
        
        cellView.layer.cornerRadius = self.frame.height / 11.0
        cellView.layer.masksToBounds = true
        
        posterImageView.layer.cornerRadius = self.frame.height / 11.0
        posterImageView.layer.masksToBounds = true
    }
}
