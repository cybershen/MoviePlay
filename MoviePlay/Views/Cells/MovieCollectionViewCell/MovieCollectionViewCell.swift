//
//  MovieCollectionViewCell.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 19.02.2023.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    let gradient = DiagonalGradient()
    
    static let identifier = "MovieCollectionViewCell"
    
    func configure(viewModel: MovieViewViewModel) {
        imageView.sd_setImage(with: viewModel.posterURL)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = cellView.bounds
        gradient.alpha = 0.2
        cellView.addSubview(gradient)
        
        cellView.layer.cornerRadius = self.frame.height / 11.0
        cellView.layer.masksToBounds = true
    }
}
