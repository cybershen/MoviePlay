//
//  Gradient.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 20.02.2023.
//

import UIKit

class GradientView: UIView {
    
    //MARK: - Constants
    
    let gradient = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame:frame)
        setupGradient(color: UIColor.orange)
        
    }
    
    //MARK: - Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient(color: UIColor.orange)
    }
    
    //MARK: - Methods
    
    func setupGradient(color: UIColor ) {
        gradient.colors = [
            UIColor.clear.cgColor,
            color.cgColor]
        
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        layer.addSublayer(gradient)
    }
    
    //MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
