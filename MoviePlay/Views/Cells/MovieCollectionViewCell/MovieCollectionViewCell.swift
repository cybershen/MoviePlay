//
//  MovieCollectionViewCell.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 19.02.2023.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    //MARK: - Constants
    
    let gradient = GradientView()
    
    static let identifier = "MovieCollectionViewCell"
    
    //MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    //MARK: - Methods
    
    func configure(viewModel: MovieViewViewModel) {
        imageView.sd_setImage(with: viewModel.posterURL)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        gradient.frame = cellView.bounds
        gradient.alpha = 0.2
        cellView.addSubview(gradient)
        
        cellView.layer.cornerRadius = self.frame.height / 11.0
        cellView.layer.masksToBounds = true
        
        imageView.contentMode = .scaleToFill
    }
}
