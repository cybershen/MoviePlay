//
//  ProfileViewController.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 20.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        mainTabBarVC.modalPresentationStyle = .fullScreen
        present(mainTabBarVC, animated: true)
    }
}
