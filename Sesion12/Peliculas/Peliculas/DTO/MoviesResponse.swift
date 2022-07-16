//
//  MoviesResponse.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 1/06/22.
//

import Foundation

struct PageMovieDTO: Decodable {
    let page: Int?
    let results: [MovieDTO]?
}

struct MovieDTO: Decodable {
    let id: Int?
    let title: String?
    let vote_average: Double?
    let release_date: String?
    let poster_path: String?
    let overview: String?
    let genres: [MovieGenreDTO]?
}

struct MovieGenreDTO: Decodable {
    let id: Int?
    let name: String?
}
