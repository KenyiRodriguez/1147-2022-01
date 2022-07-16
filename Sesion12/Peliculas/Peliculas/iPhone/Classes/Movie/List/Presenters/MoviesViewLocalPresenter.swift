//
//  MoviesViewLocalPresenter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 6/07/22.
//

import Foundation

//MARK: - Propiedades
struct MoviesViewLocalPresenter {
    
    private unowned let controller: MoviesViewProtocol
    
    init(controller: MoviesViewProtocol) {
        self.controller = controller
    }
}

//MARK: - Contrapartes
extension MoviesViewLocalPresenter: MoviesViewPresenter {
    
    func didLoad() {
        self.controller.setupAdapters()
    }
    
    func willAppear() {
        self.getAllMovies()
    }
    
    func pullToRefresh() {
        //TODO: Implementar si es necesario
    }
}

//MARK: - Habilidades
extension MoviesViewLocalPresenter {
    
    private func getAllMovies() {
        
        let context = DataManager.current.presistentContainer.viewContext
        let localStorage = MovieLS(context: context)
        
        let arrayResult = localStorage.listAll()
        let arrayMovies = arrayResult.toMovies
        
        self.controller.reloadSearchWithData(arrayMovies)
        self.controller.reloadTableWithData(arrayMovies.count > 0 ? arrayMovies : ["Aún no tienes elementos favoritos agregados"])
    }
}
