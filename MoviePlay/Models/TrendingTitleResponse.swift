//
//  TrendingTitleResponse.swift
//  MoviePlay
//
//  Created by Назар Жиленко on 14.02.2023.
//

import UIKit

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

extension TrendingTitleResponse {
    static var trendingMovies: Resource<TrendingTitleResponse> = {
        let url = URL(string:
        "\(Constants.API.baseURL)/3/trending/movie/day?api_key=\(Constants.API.API_KEY)")
        return Resource(url: url!)
    }()
    
    static var trendingTvs: Resource<TrendingTitleResponse> = {
        let url = URL(string:
        "\(Constants.API.baseURL)/3/trending/tv/day?api_key=\(Constants.API.API_KEY)")
        return Resource(url: url!)
    }()
    
    static var upcomingMovies: Resource<TrendingTitleResponse> = {
        let url = URL(string:
        "\(Constants.API.baseURL)/3/movie/upcoming?api_key=\(Constants.API.API_KEY)&languages=en-US&page=1")
        return Resource(url: url!)
    }()
    
    static var popularMovies: Resource<TrendingTitleResponse> = {
        let url = URL(string:
        "\(Constants.API.baseURL)/3/movie/popular?api_key=\(Constants.API.API_KEY)&language=en-US&page=1")
        return Resource(url: url!)
    }()
    
    static var topRatedMovies: Resource<TrendingTitleResponse> = {
        let url = URL(string:
        "\(Constants.API.baseURL)/3/movie/top_rated?api_key=\(Constants.API.API_KEY)&language=en-US&page=1")
        return Resource(url: url!)
    }()
    
    static var discoverMovies: Resource<TrendingTitleResponse> = {
        let url = URL(string:
        "\(Constants.API.baseURL)/3/discover/movie?api_key=\(Constants.API.API_KEY)&language=en-US&page=1")
        return Resource(url: url!)
    }()
    
    static var searchMovies: Resource<TrendingTitleResponse> = {
        let url = URL(string:
        "\(Constants.API.baseURL)/3/search/movie?api_key=\(Constants.API.API_KEY)")
        return Resource(url: url!)
    }()
}
