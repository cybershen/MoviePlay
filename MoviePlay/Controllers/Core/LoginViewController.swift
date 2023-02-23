//
//  LoginViewController.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 14.02.2023.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {
    
    @IBOutlet weak var viewForAnimation: UIView!
    
    private var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationView()
    }
    
    //MARK: - Private Methods
    
    private func setupAnimationView() {
        animationView = .init(name: "film")
        animationView.frame = viewForAnimation.bounds
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        viewForAnimation.addSubview(animationView)
        animationView.play()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileVC.modalPresentationStyle = .fullScreen
        present(profileVC, animated: true)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        mainTabBarVC.modalPresentationStyle = .fullScreen
        present(mainTabBarVC, animated: true)
    }
}
