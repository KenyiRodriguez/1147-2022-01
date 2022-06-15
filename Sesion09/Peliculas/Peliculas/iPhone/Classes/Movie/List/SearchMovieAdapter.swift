//
//  SearchMovieAdapter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 15/06/22.
//

import UIKit

class SearchMovieAdapter: NSObject {
    
    private unowned let controller: MoviesViewProtocol
    var arrayData = [Movie]()
    
    init(controller: MoviesViewProtocol) {
        self.controller = controller
    }
}

extension SearchMovieAdapter: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            
            let result = self.arrayData
            self.controller.didFilterWithResult(result)
            
        } else {
            
            let result = self.arrayData.filter { movie in
                return movie.title.lowercased().contains(searchText.lowercased())
            }
            
            let arrayToShow: [Any] = result.count != 0 ? result : ["No se encontraron resultados para la búsqueda de:\n\n\(searchText)"]
            
            self.controller.didFilterWithResult(arrayToShow)
        }
    }
}
