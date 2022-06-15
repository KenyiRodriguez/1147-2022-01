//
//  Movie.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 1/06/22.
//

import Foundation

struct Movie {
    
    let id: Int
    let title: String
    let voteAverage: Int
    let releaseDate: Date?
    let posterPath: String
    let overview: String
    
    var urlImage: String {
        return "https://image.tmdb.org/t/p/w500" + self.posterPath
    }
    
    var releaseDateFormat: String {
        
        guard let date = self.releaseDate else {
            return "Próximamente"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd 'de' MMMM 'del' yyyy"
        //Miercoles 1 de Junio del 2022
        dateFormatter.locale = Locale(identifier: "es_pe")
        
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    init(dto: MovieDTO) {
        self.id = dto.id ?? 0
        self.title = dto.title ?? "--"
        self.voteAverage = Int(dto.vote_average ?? 0)
        self.overview = dto.overview ?? "Sin descripción"
        self.posterPath = dto.poster_path ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "es_pe")
        self.releaseDate = dateFormatter.date(from: dto.release_date ?? "")
        
    }
}
