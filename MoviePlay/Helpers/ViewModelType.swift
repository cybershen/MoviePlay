//
//  ViewModelType.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 20.02.2023.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
