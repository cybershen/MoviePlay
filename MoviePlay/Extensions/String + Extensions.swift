//
//  String + Extensions.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 14.02.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
