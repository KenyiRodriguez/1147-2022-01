//
//  MovieDetailViewPresenter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 13/07/22.
//

import Foundation

//MARK: - Propiedades
class MovieDetailViewPresenter {
    
    private unowned let controller: MovieDetailViewController
    private var movie: Movie?
    
    init(controller: MovieDetailViewController) {
        self.controller = controller
    }
}

//MARK: - Contrapartes
extension MovieDetailViewPresenter {
    
    func didLoad() {
        self.controller.setupStyle()
        self.setAsFavorite()
        self.getDetail()
    }
    
    func backController() {
        self.controller.backController()
    }
    
    func addToFavorite() {
        
        let dataAccess = MovieLS(context: DataManager.current.presistentContainer.viewContext)
        
        if self.isFavorite {
            dataAccess.delete(self.controller.idMovie)
            DataManager.current.saveContext()
            self.controller.setupFavoriteStyle(false)
            
        } else {
            guard let movie = self.movie else { return }
            dataAccess.add(movie)
            DataManager.current.saveContext()
            self.controller.setupFavoriteStyle(true)
        }
    }
}

//MARK: - Habilidades
extension MovieDetailViewPresenter {
    
    private var isFavorite: Bool {
        let dataAccess = MovieLS(context: DataManager.current.presistentContainer.viewContext)
        let isFavorite = dataAccess.getById(self.controller.idMovie) != nil
        return isFavorite
    }
    
    private func getDetail() {
        
        let webService = MovieWS()
        
        self.controller.showLoading(true)
        webService.getDetail(self.controller.idMovie) { movieDTO in
            
            let movie = movieDTO.toMovie
            self.controller.showLoading(false)
            self.controller.updateData(movie)
            self.movie = movie
            
        } error: { errorMessage in
            
            self.controller.showLoading(true)
            print(errorMessage)
        }
    }
    
    private func setAsFavorite() {
        self.controller.setupFavoriteStyle(self.isFavorite)
    }
}
