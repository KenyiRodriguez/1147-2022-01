//
//  ListMoviesActionAdapter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 13/07/22.
//

import UIKit

class ListMoviesActionAdapter: NSObject, ListMoviesAdapter {
    
    private unowned let controller: MoviesViewProtocol
    var arrayData = [Any]()
    
    init(controller: MoviesViewProtocol) {
        self.controller = controller
    }
    
    func setTableView(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func deleteMovie(_ movie: Movie, inTableView tableView: UITableView, indexPath: IndexPath) {
        
        self.controller.deleteMovieInSearch(movie)
        self.arrayData.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        let dataAccess = MovieLS(context: DataManager.current.presistentContainer.viewContext)
        dataAccess.delete(movie.id)
        DataManager.current.saveContext()
    }
}

extension ListMoviesActionAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let element = self.arrayData[indexPath.row]
        
        if let movie = element as? Movie {
            return MovieTableViewCell.createIn(tableView, indexPath: indexPath, movie: movie)
            
        } else if let errorMessage = element as? String {
            return ErrorTableViewCell.createIn(tableView, indexPath: indexPath, errorMessage: errorMessage)
            
        } else {
            return UITableViewCell()
        }
    }
}

extension ListMoviesActionAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let movie = self.arrayData[indexPath.row] as? Movie {
            self.controller.goToDetailMovie(movie)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch self.arrayData[indexPath.row] {
        case is Movie:
            return UITableView.automaticDimension
        case is String:
            return tableView.frame.height
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let movie = self.arrayData[indexPath.row] as? Movie else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Eliminar") { _, _, _ in
            self.deleteMovie(movie, inTableView: tableView, indexPath: indexPath)
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        let detailAction = UIContextualAction(style: .normal, title: "Ver detalle") { _, _, _ in
            self.controller.goToDetailMovie(movie)
        }
        detailAction.backgroundColor = .systemIndigo
        detailAction.image = UIImage(systemName: "doc.richtext")
        
        let actions = UISwipeActionsConfiguration(actions: [deleteAction, detailAction])
        return actions
    }
}

