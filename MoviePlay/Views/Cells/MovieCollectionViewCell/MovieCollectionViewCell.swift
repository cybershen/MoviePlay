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
    
    static let identifier = "MovieCollectionViewCell"
    
    func configure(viewModel: MovieViewViewModel) {
        imageView.sd_setImage(with: viewModel.posterURL)
    }
}
