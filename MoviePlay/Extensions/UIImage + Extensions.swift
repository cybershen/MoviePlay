//
//  UIImage + Extensions.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 14.02.2023.
//

import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        case house = "house"
        case playCircle = "play.circle"
        case magnifyingGlass = "magnifyingglass"
        case arrowDownToLine = "arrow.down.to.line"
    }
    
    convenience init(assetIdentifier: AssetIdentifier) {
        self.init(systemName: assetIdentifier.rawValue)!
    }
}
