//
//  DetailMovieViewController.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 22.02.2023.
//

import UIKit
import Lottie
import SDWebImage

class DetailMovieViewController: UIViewController {
    
    @IBOutlet weak var viewForAnimation: UIView!
    @IBOutlet weak var nameLabel: GradientLabel!
    @IBOutlet weak var descriptionLabel: GradientLabel!
    @IBOutlet weak var releaseLabel: GradientLabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var myModel: MovieViewViewModel!
    private var animationView: LottieAnimationView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientForLabels()
        configure(viewModel: myModel)
        blurImage()
        setupAnimationView()
    }
    
    func configure(viewModel: MovieViewViewModel) {
        configureLabel(with: nameLabel, and: viewModel.title)
        configureLabel(with: descriptionLabel, and: viewModel.overview)
        configureLabel(with: releaseLabel, and: viewModel.releaseDate)
        imageView.sd_setImage(with: viewModel.posterURL)
    }
    
    //MARK: - Private Methods
    
    private func configureGradientForLabels() {
        nameLabel.gradientColors = [UIColor.purple.cgColor, UIColor.red.cgColor]
        descriptionLabel.gradientColors = [UIColor.purple.cgColor, UIColor.orange.cgColor]
        releaseLabel.gradientColors = [UIColor.red.cgColor, UIColor.purple.cgColor]
    }
    
    private func blurImage() {
        imageView.alpha = 0.75
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
    }
    
    private func setupAnimationView() {
        animationView = .init(name: "astronaut")
        animationView.frame = viewForAnimation.bounds
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        viewForAnimation.addSubview(animationView)
        animationView.play()
    }
    
    private func configureLabel(with label: UILabel, and str: String) {
        label.text = ""
        var charIndex = 0.0
        
        for character in str {
            Timer.scheduledTimer(withTimeInterval: 0.020 * charIndex, repeats: false) {
                (timer) in label.text?.append(character)
            }
            charIndex += 1
        }
    }
}

