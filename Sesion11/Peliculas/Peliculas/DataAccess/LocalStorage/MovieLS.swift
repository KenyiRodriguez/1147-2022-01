//
//  MovieLS.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 6/07/22.
//

import CoreData

struct MovieLS {
    
    let context: NSManagedObjectContext
    
    func add(_ movie: Movie) {
        let objDM = NSEntityDescription.insertNewObject(forEntityName: "FavoriteMovie", into: self.context) as? FavoriteMovie
        objDM?.title = movie.title
        objDM?.id = Int32(movie.id)
        objDM?.posterPath = movie.posterPath
        objDM?.voteAverage = Int16(movie.voteAverage)
        objDM?.releaseDate = movie.releaseDate
    }
    
    func searchByKey(_ key: String) -> [FavoriteMovie] {
        []
    }
    
    func listAll() -> [FavoriteMovie] {
        []
    }
    
    func getById(_ idMovie: Int) -> FavoriteMovie? {
        nil
    }
    
    func delete(_ idMovie: Int) {
        
    }
}
