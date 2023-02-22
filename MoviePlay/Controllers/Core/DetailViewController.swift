//
//  DetailViewController.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 22.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    @IBOutlet weak var videoStr: UILabel!
    
    var str: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(str)
        get()
    }
    
    func get() {
        let link = "https://www.youtube.com/watch?v=\(str)"
        if let videoID = URLComponents(string: link)?.queryItems?.filter({$0.name == "v"}).first?.value {
            print(videoID) // "ABCDE"
        }
    }
    
}
