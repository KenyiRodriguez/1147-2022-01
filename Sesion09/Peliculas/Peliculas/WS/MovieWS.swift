//
//  MovieWS.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 18/05/22.
//

import Foundation
import Alamofire
import UIKit

typealias MoviesHandler = (_ arrayMoviesDTO: [MovieDTO]) -> Void

struct MovieWS {
    
    func getAllMovies(success: @escaping MoviesHandler) {
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c"
        let request = AF.request(urlString, method: .get)

        request.response { dataResponse in
            
            guard let data = dataResponse.data else {
                print("Ocurrio un problema. Inténtalo más tarde")
                return
            }
            
            let decoder = JSONDecoder()
            let pageMovie = try? decoder.decode(PageMovieDTO.self, from: data)
            success(pageMovie?.results ?? [])
        }
    }
}
