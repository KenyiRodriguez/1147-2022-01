//
//  MoviesViewOnlinePresenter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 6/07/22.
//

import Foundation

//MARK: - Propiedades
struct MoviesViewOnlinePresenter {
    
    private unowned let controller: MoviesViewProtocol
    
    init(controller: MoviesViewProtocol) {
        self.controller = controller
    }
}

//MARK: - Contrapartes
extension MoviesViewOnlinePresenter: MoviesViewPresenter {
    
    func didLoad() {
        self.controller.addPullToRefresh()
        self.controller.setupAdapters()
        self.getAllMovies()
    }
    
    func willAppear() {
        //TODO: Implementar si es necesario
    }
    
    func pullToRefresh() {
        self.getAllMovies()
    }
}

//MARK: - Habilidades
extension MoviesViewOnlinePresenter {
    
    private func getAllMovies() {
        
        let ws = MovieWS()
        
        self.controller.showLoading(true)

        ws.getAllMovies { arrayMoviesDTO in
            
            self.controller.showLoading(false)
            let arrayMovies = arrayMoviesDTO.toMovies
            
            self.controller.reloadSearchWithData(arrayMovies)
            self.controller.reloadTableWithData(arrayMovies)
        }
    }
}
